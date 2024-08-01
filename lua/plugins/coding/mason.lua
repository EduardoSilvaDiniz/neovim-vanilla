return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  build = function()
    pcall(vim.cmd, "MasonUpdate")
  end,
  config = function()
    require("mason").setup()
    require("mason-tool-installer").setup({
      ensure_installed = require("custom.servers"),
      auto_update = true,
    })
  end,
}
