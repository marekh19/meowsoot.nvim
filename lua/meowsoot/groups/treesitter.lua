-- Treesitter @*-groups. Links to native syntax groups where possible;
-- overrides only where treesitter-specific nuance helps.
-- No-green-in-code policy enforced: escape/special chars use peach;
-- checked-list markers use cyan; diff.plus links to DiffAdd (which uses c.git.add).

local M = {}

---@type fun(c: table, opts: table): table
function M.get(c, opts)
  local styles = opts.styles or {}
  -- stylua: ignore
  return {
    -- Comments
    ["@comment"]                     = "Comment",
    ["@comment.documentation"]       = { fg = c.comment, italic = true },
    ["@comment.error"]               = { fg = c.error,   italic = true, bold = true },
    ["@comment.warning"]             = { fg = c.warning, italic = true, bold = true },
    ["@comment.hint"]                = { fg = c.hint,    italic = true, bold = true },
    ["@comment.info"]                = { fg = c.info,    italic = true, bold = true },
    ["@comment.note"]                = { fg = c.cyan,    italic = true, bold = true },
    ["@comment.todo"]                = "Todo",

    -- Punctuation
    ["@punctuation"]                 = { fg = c.fg_faint },
    ["@punctuation.delimiter"]       = { fg = c.fg_faint },
    ["@punctuation.bracket"]         = { fg = c.fg_faint },
    ["@punctuation.special"]         = { fg = c.peach },

    -- Constants
    ["@constant"]                    = "Constant",
    ["@constant.builtin"]            = { fg = c.peach },
    ["@constant.macro"]              = { fg = c.peach },

    -- Strings (NEVER green)
    ["@string"]                      = "String",
    ["@string.documentation"]        = { fg = c.comment, italic = true },
    ["@string.regexp"]               = { fg = c.yellow },
    ["@string.escape"]               = { fg = c.peach }, -- was green
    ["@string.special"]              = { fg = c.peach }, -- was green
    ["@string.special.symbol"]       = { fg = c.peach },
    ["@string.special.url"]          = { fg = c.cyan, underline = true },

    ["@character"]                   = "Character",
    ["@character.special"]           = { fg = c.peach }, -- was green
    ["@character.printf"]            = { fg = c.peach },

    -- Numbers
    ["@number"]                      = { fg = c.peach_dim },
    ["@number.float"]                = { fg = c.peach_dim },
    ["@float"]                       = { fg = c.peach_dim },
    ["@boolean"]                     = "Boolean",

    -- Functions
    ["@function"]                    = { fg = c.pink, style = styles.functions },
    ["@function.builtin"]            = { fg = c.pink, style = styles.functions },
    ["@function.call"]               = "@function",
    ["@function.macro"]              = { fg = c.pink, style = styles.functions },
    ["@function.method"]             = "@function",
    ["@function.method.call"]        = "@function.method",
    ["@constructor"]                 = { fg = c.lavender },

    -- Operators
    ["@operator"]                    = { fg = c.fg_faint },

    -- Keywords
    ["@keyword"]                     = { fg = c.cyan, style = styles.keywords },
    ["@keyword.coroutine"]           = "@keyword",
    ["@keyword.function"]            = "@keyword",
    ["@keyword.operator"]            = "@keyword",
    ["@keyword.import"]              = "@keyword",
    ["@keyword.type"]                = "@keyword",
    ["@keyword.modifier"]            = "@keyword",
    ["@keyword.repeat"]              = "@keyword",
    ["@keyword.return"]              = "@keyword",
    ["@keyword.debug"]               = "@keyword",
    ["@keyword.exception"]           = "@keyword",
    ["@keyword.conditional"]         = "@keyword",
    ["@keyword.conditional.ternary"] = "@keyword",
    ["@keyword.directive"]           = "@keyword",
    ["@keyword.directive.define"]    = "@keyword",
    ["@keyword.export"]              = "@keyword",
    ["@keyword.storage"]             = "@keyword",

    -- Types
    ["@type"]                        = { fg = c.lavender },
    ["@type.builtin"]                = { fg = c.lavender },
    ["@type.definition"]             = { fg = c.lavender },
    ["@type.qualifier"]              = "@keyword",

    -- Attributes / decorators
    ["@attribute"]                   = { fg = c.peach_br, italic = true },
    ["@attribute.builtin"]           = { fg = c.peach_br, italic = true },

    -- Properties / fields
    ["@property"]                    = { fg = c.fg },
    ["@field"]                       = { fg = c.fg },

    -- Variables
    ["@variable"]                    = { fg = c.fg, style = styles.variables },
    ["@variable.builtin"]            = { fg = c.cyan, italic = true },
    ["@variable.parameter"]          = { fg = c.fg, italic = true },
    ["@variable.parameter.builtin"]  = { fg = c.fg, italic = true },
    ["@variable.member"]             = { fg = c.fg },

    -- Modules
    ["@module"]                      = { fg = c.lavender },
    ["@module.builtin"]              = { fg = c.lavender },
    ["@namespace"]                   = { fg = c.lavender },
    ["@namespace.builtin"]           = "@variable.builtin",
    ["@label"]                       = { fg = c.cyan },

    -- Tags (HTML / JSX)
    ["@tag"]                         = { fg = c.cyan },
    ["@tag.builtin"]                 = { fg = c.cyan },
    ["@tag.attribute"]               = { fg = c.fg, italic = true },
    ["@tag.delimiter"]               = { fg = c.fg_faint },

    -- Markup (markdown, docstrings)
    ["@markup"]                      = { fg = c.fg },
    ["@markup.strong"]               = { fg = c.peach, bold = true },
    ["@markup.italic"]               = { fg = c.yellow, italic = true },
    ["@markup.emphasis"]             = { italic = true },
    ["@markup.strikethrough"]        = { fg = c.fg_mute, strikethrough = true },
    ["@markup.underline"]            = { underline = true },
    ["@markup.heading"]              = { fg = c.pink,  bold = true },
    ["@markup.heading.1"]            = { fg = c.pink,  bold = true },
    ["@markup.heading.2"]            = { fg = c.pink,  bold = true },
    ["@markup.heading.3"]            = { fg = c.peach, bold = true },
    ["@markup.heading.4"]            = { fg = c.peach, bold = true },
    ["@markup.heading.5"]            = { fg = c.yellow, bold = true },
    ["@markup.heading.6"]            = { fg = c.yellow, bold = true },
    ["@markup.quote"]                = { fg = c.fg_mute, italic = true },
    ["@markup.math"]                 = { fg = c.peach },
    ["@markup.link"]                 = { fg = c.cyan },
    ["@markup.link.label"]           = { fg = c.lavender },
    ["@markup.link.label.symbol"]    = "Identifier",
    ["@markup.link.url"]             = { fg = c.cyan, underline = true },
    ["@markup.raw"]                  = { fg = c.lavender },
    ["@markup.raw.block"]            = { fg = c.lavender, bg = c.bg_1 },
    ["@markup.raw.markdown_inline"]  = { fg = c.lavender, bg = c.bg_1 },
    ["@markup.list"]                 = { fg = c.cyan },
    ["@markup.list.checked"]         = { fg = c.cyan },        -- was green; cyan = UI marker
    ["@markup.list.unchecked"]       = { fg = c.fg_faint },
    ["@markup.environment"]          = "Macro",
    ["@markup.environment.name"]     = "Type",

    -- Diff (link to DiffAdd/DiffChange/DiffDelete, which use c.git.* + bg blends)
    ["@diff.plus"]                   = { fg = c.git.add },
    ["@diff.minus"]                  = { fg = c.git.delete },
    ["@diff.delta"]                  = { fg = c.git.change },
  }
end

return M
