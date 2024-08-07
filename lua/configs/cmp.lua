Cmp = {}
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

function Cmp:setupConfigs()
  return cmp.setup({
    snippet = self:setSnippet(),
    window = self:setWindow(),
    enabled = self:setEnabled(),
    mapping = self:setMapping(),
    sources = self:setSources(),
    sorting = self:setSorting(),
    preselect = self:setPreselect(),
    formatting = self:setFormatting(),
    confirmation = self:setConfirmation(),
  })
end

function Cmp:setWindow()
  return {
    completion = cmp.config.window.bordered({
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None,CursorLine:MyCursorLine",
      side_padding = 0,
    }),
  }
end

function Cmp:setSnippet()
  return {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  }
end

function Cmp:setEnabled()
  return {
    function()
      local context = require("cmp.config.context")
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end,
  }
end

function Cmp:setMapping()
  local cmp_action = require("Factory"):new("actions", "cmp")
  return {
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-f"] = cmp_action.luasnip_jump_forward(),
    ["<C-b"] = cmp_action.luasnip_jump_backward(),
    ["<Tab>"] = cmp_action.luasnip_supertab(),
    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
  }
end

function Cmp:setSources()
  return {
    { name = "luasnip", keyword_length = 2 },
    { name = "nvim_lsp" },
    { name = "buffer",  keyword_length = 3 },
    { name = "path" },
  }
end

function Cmp:setSorting()
  return {
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.recently_used,
      cmp.config.compare.score,
    },
  }
end

function Cmp:setPreselect()
  return require("cmp").PreselectMode.None
end

function Cmp:setFormatting()
  local icons = require("assets.icons")
  vim.api.nvim_set_hl(0, "MyCursorLine", { bg = "#988829", fg = "#000000", bold = true })
  return {
    fields = { "kind", "abbr", "menu" },
    format = function(_, vim_item)
      local kind = vim_item.kind
      vim_item.kind = icons[vim_item.kind] or ""
      vim_item.menu = " (" .. kind .. ") "

      return vim_item
    end,
  }
end

function Cmp:setConfirmation()
  return {
    completeopt = "menu,menuone,noinsert"
  }
end

function Cmp:addPairsAutomaticallyByAutopairs()
  return cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

function Cmp:addSnippetsFromFriendlySnippets()
  return require('luasnip_snippets.common.snip_utils').setup()
end

function Cmp:addAutocompleteOnSearching()
  return cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
end

function Cmp:addAutocompleteOnCommandline()
  return cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
  })
end

return Cmp
