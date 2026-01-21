local data = assert(vim.fn.stdpath "data") --[[@as string]]
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

require("telescope").setup {
  pickers = {
    live_grep = {
      additional_args = function(opts)
        if show_ignored then
          return { "--hidden", "--no-ignore", "--no-ignore-vcs" }
        else
          return { "--hidden" }
        end
      end,
    },
    find_files = {
      find_command = function()
        if show_ignored then
          return { "rg", "--files", "--hidden", "--no-ignore", "--no-ignore-vcs" }
        else
          return { "rg", "--files", "--hidden" }
        end
      end,
    },
  },
  defaults = {
    path_display = { "truncate" },
    file_ignore_patterns = { "package-lock", "node_modules", "Cargo.lock", "target/" },
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = " >",
    color_devicons = true,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    preview_cutoff = 1,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-w>"] = actions.send_to_qflist,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-u>"] = function(prompt_bufnr)
          show_ignored = not show_ignored
          print("Show ignored files: " .. tostring(show_ignored))
          actions.close(prompt_bufnr)
          vim.schedule(function()
            require("telescope.builtin").find_files()
          end)
        end,
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
    file_browser = {
      hijack_netrw = false,
      mappings = {
        ["i"] = {},
        ["n"] = {},
      },
    },
    history = {
      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
      limit = 100,
    },
  },
}

require("telescope").load_extension "file_browser"
require("telescope").load_extension "fzf"
require("telescope").load_extension "ui-select"
