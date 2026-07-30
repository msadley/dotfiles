#!/usr/bin/env python3
import subprocess
import sys
import os
import time
import threading
import readline
import glob
from pathlib import Path

# --- TUI Elements ---


class Colors:
    CYAN = "\033[96m"
    GREEN = "\033[92m"
    YELLOW = "\033[93m"
    RED = "\033[91m"
    BOLD = "\033[1m"
    ITALIC = "\033[3m"
    RESET = "\033[0m"


class Spinner:
    """A threaded braille spinner to mimic rich.console.status"""

    def __init__(self, message):
        self.message = message
        self.running = False
        self.thread = None

    def spin(self):
        chars = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"]
        i = 0
        while self.running:
            sys.stdout.write(f"\r{Colors.GREEN}{chars[i]} {self.message}{Colors.RESET}")
            sys.stdout.flush()
            i = (i + 1) % len(chars)
            time.sleep(0.08)

        # Clear the line when done
        sys.stdout.write("\r" + " " * (len(self.message) + 4) + "\r")
        sys.stdout.flush()

    def __enter__(self):
        self.running = True
        self.thread = threading.Thread(target=self.spin, daemon=True)
        self.thread.start()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.running = False
        if self.thread:
            self.thread.join()


def print_banner():
    title = "GIF Circle Cropper"
    subtitle = "Perfect for Arch Linux / Discord / GitHub profile pictures"
    width = max(len(title), len(subtitle)) + 4

    print(f"{Colors.CYAN}┌{'─' * width}┐{Colors.RESET}")
    print(
        f"{Colors.CYAN}│{Colors.BOLD}{title.center(width)}{Colors.RESET}{Colors.CYAN}│{Colors.RESET}"
    )
    print(
        f"{Colors.CYAN}│{Colors.ITALIC}{subtitle.center(width)}{Colors.RESET}{Colors.CYAN}│{Colors.RESET}"
    )
    print(f"{Colors.CYAN}└{'─' * width}┘{Colors.RESET}")


def path_completer(text, state):
    """Provides tab-completion for file paths."""
    matches = glob.glob(text + "*")
    matches = [m + "/" if os.path.isdir(m) else m for m in matches]
    try:
        return matches[state]
    except IndexError:
        return None


# Enable tab completion
readline.set_completer_delims(" \t\n;")
readline.parse_and_bind("tab: complete")
readline.set_completer(path_completer)


# --- ImageMagick Logic ---


def check_imagemagick():
    """Verify ImageMagick 7 is installed."""
    try:
        subprocess.run(
            ["magick", "-version"], capture_output=True, text=True, check=True
        )
        return True
    except (FileNotFoundError, subprocess.CalledProcessError):
        return False


def get_gif_dimensions(filepath):
    """Extracts width and height of the first frame."""
    try:
        result = subprocess.run(
            ["magick", "identify", "-format", "%w %h", f"{filepath}[0]"],
            capture_output=True,
            text=True,
            check=True,
        )
        w, h = map(int, result.stdout.strip().split())
        return w, h
    except Exception as e:
        raise RuntimeError(f"Failed to read file: {e}")


def process_gif(input_path, output_path, base_size, crop_size):
    """
    Crops tighter into the GIF, re-pads the canvas with transparency,
    and applies an exactly fitted circular mask.
    """
    # Calculate mask parameters based on the canvas and crop size
    center = base_size / 2.0
    radius = crop_size / 2.0
    edge_y = center - radius

    # ImageMagick 7 Command structure:
    # 1. -crop: Crops tighter into the center based on padding
    # 2. -extent: Re-pads the image back to its original max square with transparency
    # 3. ( ... ): Generates a circle mask perfectly fitted to the new inner cropped image
    cmd = [
        "magick",
        input_path,
        "-coalesce",
        "-gravity",
        "center",
        "-crop",
        f"{crop_size}x{crop_size}+0+0",
        "+repage",
        "-background",
        "transparent",
        "-extent",
        f"{base_size}x{base_size}",
        "-alpha",
        "set",
        "null:",
        "(",
        "-size",
        f"{base_size}x{base_size}",
        "xc:transparent",
        "-fill",
        "white",
        "-draw",
        f"circle {center:g},{center:g} {center:g},{edge_y:g}",
        ")",
        "-compose",
        "DstIn",
        "-layers",
        "composite",
        "-layers",
        "optimize",
        output_path,
    ]

    subprocess.run(cmd, check=True, capture_output=True)


# --- Main Application ---


def main():
    print_banner()

    if not check_imagemagick():
        print(
            f"{Colors.RED}{Colors.BOLD}Error:{Colors.RESET} ImageMagick ('magick' command) not found."
        )
        print(
            f"Install it on Arch via: {Colors.YELLOW}sudo pacman -S imagemagick{Colors.RESET}"
        )
        sys.exit(1)

    # 1. Input Prompt loop
    input_gif = ""
    while True:
        try:
            input_gif = input(
                f"{Colors.BOLD}? Select the input GIF:{Colors.RESET} (Tab to autocomplete) \n> "
            ).strip()
            if not input_gif:
                continue
            if not os.path.isfile(input_gif) or not input_gif.lower().endswith(".gif"):
                print(f"{Colors.RED}Please select a valid .gif file.{Colors.RESET}")
                continue
            break
        except EOFError:
            sys.exit(0)

    # 2. Analyze Dimensions
    try:
        with Spinner("Analyzing GIF..."):
            w, h = get_gif_dimensions(input_gif)
            base_size = min(w, h)
            max_pad = (base_size // 2) - 1
    except RuntimeError as e:
        print(f"\n{Colors.RED}{Colors.BOLD}Error:{Colors.RESET} {e}")
        sys.exit(1)

    # 3. Padding Prompt
    padding = 0
    while True:
        try:
            pad_prompt = (
                f"\n{Colors.BOLD}? Enter padding in pixels{Colors.RESET} "
                f"(Crops tighter & adds transparent margin, 0-{max_pad}, Default: 0)\n> "
            )
            pad_str = input(pad_prompt).strip()

            if not pad_str:
                padding = 0
                break

            padding = int(pad_str)
            if 0 <= padding <= max_pad:
                break
            else:
                print(
                    f"{Colors.RED}Please enter a number between 0 and {max_pad}.{Colors.RESET}"
                )
        except ValueError:
            print(f"{Colors.RED}Please enter a valid integer.{Colors.RESET}")
        except EOFError:
            sys.exit(0)

    crop_size = base_size - (2 * padding)

    # 4. Output Prompt
    readline.set_completer(
        lambda text, state: None
    )  # Disable path completion for output
    default_out = str(Path(input_gif).with_name(f"{Path(input_gif).stem}_circle.gif"))
    try:
        output_gif = input(
            f"\n{Colors.BOLD}? Enter output filename:{Colors.RESET} (Default: {default_out})\n> "
        ).strip()
        if not output_gif:
            output_gif = default_out
    except EOFError:
        sys.exit(0)

    # 5. Processing
    msg = f"Processing ({w}x{h} -> padded {crop_size}x{crop_size} circle)... This may take a moment..."
    with Spinner(msg):
        try:
            process_gif(input_gif, output_gif, base_size, crop_size)
            print(
                f"{Colors.GREEN}{Colors.BOLD}✓ Success!{Colors.RESET} Saved to {Colors.YELLOW}{output_gif}{Colors.RESET}"
            )
        except subprocess.CalledProcessError as e:
            print(f"{Colors.RED}{Colors.BOLD}✗ Failed to process GIF{Colors.RESET}")
            print(f"Error output: {e.stderr.decode('utf-8', errors='ignore')}")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print(f"\n{Colors.YELLOW}Cancelled by user.{Colors.RESET}")
        sys.exit(0)
