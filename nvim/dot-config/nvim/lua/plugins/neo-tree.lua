return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    hide_root_node = true,
    retain_hidden_root_indent = true,
    window = {
      width = 45,
    },
    filesystem = {
      group_empty_dirs = true,
      scan_mode = "deep",
      filtered_items = {
        visible = false,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
    source_selector = {
      winbar = false,
      statusline = false,
    },
  },
}
