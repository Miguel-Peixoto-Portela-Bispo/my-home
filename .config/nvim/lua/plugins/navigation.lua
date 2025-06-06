return {
  -- {
  -- 	"stevearc/oil.nvim",
  -- 	opts = {},
  -- 	config = function()
  -- 		require("oil").setup({
  -- 			default_file_explorer = true,
  -- 			columns = {
  -- 				"size",
  -- 				"icon",
  -- 			},
  -- 			keymaps = {
  -- 				["<leader>rf"] = "actions.refresh",
  -- 				["-"] = "actions.parent",
  -- 				["_"] = "actions.open_cwd",
  -- 			},
  -- 			view_options = {
  -- 				show_hidden = true,
  -- 				is_hidden_file = function(name, _)
  -- 					return vim.startswith(name, ".")
  -- 				end,
  -- 				case_insensitive = false,
  -- 				sort = {
  -- 					{ "type", "asc" },
  -- 					{ "name", "asc" },
  -- 				},
  -- 				is_always_hidden = function(name, _)
  -- 					if name == ".." or name == ".git" then
  -- 						return true
  -- 					end
  -- 					return false
  -- 				end,
  -- 			},
  -- 		})
  -- 		vim.keymap.set("n", "-", function()
  -- 			require("oil").open()
  -- 		end)
  -- 	end,
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        }
      }
    end
  },
  -- {
  --   "romgrk/barbar.nvim",
  --   dependencies = {
  --     "lewis6991/gitsigns.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   init = function()
  --     vim.g.barbar_auto_setup = false
  --     local map = vim.api.nvim_set_keymap
  --     local opts = { silent = true }
  --
  --     map("n", "<C-h>", "<Cmd>BufferPrevious<CR>", opts)
  --     map("n", "<C-l>", "<Cmd>BufferNext<CR>", opts)
  --
  --     map("n", "<C-S-h>", "<Cmd>BufferMovePrevious<CR>", opts)
  --     map("n", "<C-S-l>", "<Cmd>BufferMoveNext<CR>", opts)
  --
  --     map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
  --     map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
  --     map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
  --     map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
  --     map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
  --     map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
  --     map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
  --     map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
  --     map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
  --     map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
  --
  --     map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
  --
  --     map("n", "<C-c>", "<Cmd>BufferClose<CR>", opts)
  --
  --     map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
  --
  --     map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
  --     map("n", "<Space>bn", "<Cmd>BufferOrderByName<CR>", opts)
  --     map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
  --     map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
  --     map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)
  --   end,
  --   opts = {},
  -- },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end,
  },
}
