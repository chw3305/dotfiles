return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- main branch does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({})

    -- replaces ensure_installed
    require("nvim-treesitter").install({ "lua" })

    -- replaces highlight/indent = { enable = true }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lua" },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
