if not pcall(require, "nvim-treesitter.configs") then
  return
end

vim.opt.indentexpr = "nvim_treesitter#indent()"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
-- These two are optional and provide syntax highlighting
-- for Neorg tables and the @document.meta tag
parser_configs.norg_meta = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
    files = { "src/parser.c" },
    branch = "main",
  },
}

parser_configs.norg_table = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
    files = { "src/parser.c" },
    branch = "main",
  },
}

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "cpp",
    "vim",
    "query",
    "java",
    "rust",
    "python",
    "lua",
    "cuda",
    "javascript",
    "norg",
    "norg_meta",
    "norg_table",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
  matchup = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  rainbow = {
    enable = true,
    disabled = {
      "vim",
    },
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ["i,"] = "@param.inner",
        ["a,"] = "@param.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>rj"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>rk"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = { query = "@function.name", desc = "Next function start" },
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        ["]h"] = { query = "@include", desc = "Next include/import statement" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "Next function end" },
        ["]["] = { query = "@class.outer", desc = "Next class end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.name", desc = "Previous function start" },
        ["[["] = { query = "@class.outer", desc = "Previous class start" },
        ["[h"] = { query = "@include", desc = "Previous include/import statement" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
        ["[]"] = { query = "@class.outer", desc = "Previous class end" },
      },
    },
  },
}

vim.api.nvim_set_hl(0, "@python.self", { link = "pythonTSSelf" })
vim.api.nvim_set_hl(0, "@python.docstring", { link = "pythonTSDocstring" })
vim.api.nvim_set_hl(0, "@lua.vim", { link = "Constructor" })

-- vim.treesitter.set_query(
--   "cpp",
--   "textobjects",
--   [=[
-- (function_definition
--   declarator: (function_declarator
--     declarator: [
--         (identifier) @function.name
--         (qualified_identifier
--             name: (identifier) @function.name)
-- ]))
-- ]=]
-- )

local success, wk = pcall(require, "which-key")
if not success then
  return
end

wk.register {
  ["<leader>rj"] = "Swap with next parameter",
  ["<leader>rk"] = "Swap with previous parameter",
}

wk.register({
  ["if"] = "inner function",
  ["af"] = "a function (with signature)",
  ["ic"] = "inner class",
  ["ac"] = "a class (with class keyword)",
  ["i,"] = "inner parameter",
  ["a,"] = "a parameter with type",
}, {
  mode = "x",
})

wk.register({
  ["if"] = "inner function",
  ["af"] = "a function (with signature)",
  ["ic"] = "inner class",
  ["ac"] = "a class (with class keyword)",
  ["i,"] = "inner parameter",
  ["a,"] = "a parameter with type",
}, {
  mode = "o",
})
