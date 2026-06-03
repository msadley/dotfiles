return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      group_empty_dirs = true,
      filtered_items = {
        never_show = {
          ".DS_Store",
        },
      },
    },
    source_selector = {
      winbar = false,
      statusline = false,
    },
  },
}
