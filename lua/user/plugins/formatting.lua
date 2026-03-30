return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "oxfmt", "prettier", stop_after_first = true },
        typescript = { "oxfmt", "prettier", stop_after_first = true },
        javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
        typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
        handlebars = { "oxfmt", "prettier", stop_after_first = true },
        json = { "oxfmt", "prettier", stop_after_first = true },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
      },
      formatters = {
        oxfmt = {
          command = "oxfmt",
          args = { "--stdin-filepath", "$FILENAME" },
          stdin = true,
          cwd = require("conform.util").root_file({ ".oxfmtrc.json" }),
          require_cwd = true,
        },
        prettier = {
          -- Prettier 3.6.2 has a bug where --config-path doesn't work with stdin
          -- Use tmpfile mode instead so prettier can discover config properly
          stdin = false,
          args = { "--write", "$FILENAME" },
        },
      },
      format_on_save = {
        lsp_format = "fallback",
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n" }, "<leader>cf", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file" })
  end,
}
