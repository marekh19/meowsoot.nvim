local Util = require("meowsoot.util")

local M = {}

-- Bat and delta both consume this legacy Sublime Text plist through bat's
-- compiled theme cache. Keep scope colors aligned with the Neovim groups.
local template = [[
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>name</key>
  <string>${scheme_name}</string>
  <key>author</key>
  <string>meowsoot.nvim contributors</string>
  <key>colorSpaceName</key>
  <string>sRGB</string>
  <key>semanticClass</key>
  <string>theme.meowsoot.${scheme_name}</string>
  <key>settings</key>
  <array>
    <dict>
      <key>settings</key>
      <dict>
        <key>background</key>
        <string>${bg_0}</string>
        <key>foreground</key>
        <string>${fg}</string>
        <key>caret</key>
        <string>${pink}</string>
        <key>selection</key>
        <string>${bg_3}</string>
        <key>lineHighlight</key>
        <string>${bg_2}</string>
        <key>gutterForeground</key>
        <string>${fg_faint}</string>
        <key>invisibles</key>
        <string>${bg_4}</string>
        <key>activeGuide</key>
        <string>${border_highlight}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Comments</string>
      <key>scope</key>
      <string>comment, punctuation.definition.comment</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${comment}</string>
        <key>fontStyle</key>
        <string>italic</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Strings</string>
      <key>scope</key>
      <string>string, constant.other.symbol</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${yellow}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Regular expressions</string>
      <key>scope</key>
      <string>string.regexp</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${yellow}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Escapes and special characters</string>
      <key>scope</key>
      <string>constant.character, constant.character.escape, constant.other.placeholder, punctuation.section.embedded</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${peach}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Numbers</string>
      <key>scope</key>
      <string>constant.numeric</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${peach_dim}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Constants and booleans</string>
      <key>scope</key>
      <string>constant.language, constant.other, variable.other.constant</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${peach}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Functions and methods</string>
      <key>scope</key>
      <string>entity.name.function, entity.name.function.preprocessor, support.function, variable.function, meta.function-call variable</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${pink}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Types, classes, and namespaces</string>
      <key>scope</key>
      <string>entity.name.type, entity.name.class, entity.name.namespace, entity.other.inherited-class, support.type, support.class</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${lavender}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Keywords and storage</string>
      <key>scope</key>
      <string>keyword, storage.type, storage.modifier</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${cyan}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Operators</string>
      <key>scope</key>
      <string>keyword.operator</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${fg_faint}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Built-in variables</string>
      <key>scope</key>
      <string>variable.language, variable.other.readwrite.instance</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${cyan}</string>
        <key>fontStyle</key>
        <string>italic</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Variables and properties</string>
      <key>scope</key>
      <string>variable, variable.parameter, variable.other, support.variable, meta.object-literal.key, meta.mapping.key</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${fg}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Labels and tags</string>
      <key>scope</key>
      <string>entity.name.label, entity.name.tag</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${cyan}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Attributes and decorators</string>
      <key>scope</key>
      <string>entity.other.attribute-name, meta.decorator, punctuation.decorator</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${peach_br}</string>
        <key>fontStyle</key>
        <string>italic</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Punctuation</string>
      <key>scope</key>
      <string>punctuation.separator, punctuation.terminator, punctuation.definition.tag, punctuation.section.block, punctuation.section.group</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${fg_faint}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Headings</string>
      <key>scope</key>
      <string>markup.heading, entity.name.section</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${pink}</string>
        <key>fontStyle</key>
        <string>bold</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Bold markup</string>
      <key>scope</key>
      <string>markup.bold</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${peach}</string>
        <key>fontStyle</key>
        <string>bold</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Italic markup</string>
      <key>scope</key>
      <string>markup.italic</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${yellow}</string>
        <key>fontStyle</key>
        <string>italic</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Links</string>
      <key>scope</key>
      <string>markup.underline.link, string.other.link</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${cyan}</string>
        <key>fontStyle</key>
        <string>underline</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Raw markup</string>
      <key>scope</key>
      <string>markup.raw, markup.inline.raw</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${lavender}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Inserted diff content</string>
      <key>scope</key>
      <string>markup.inserted</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${git.add}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Deleted diff content</string>
      <key>scope</key>
      <string>markup.deleted</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${git.delete}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Changed diff content</string>
      <key>scope</key>
      <string>markup.changed</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${git.change}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Invalid</string>
      <key>scope</key>
      <string>invalid, invalid.illegal</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>${error}</string>
        <key>fontStyle</key>
        <string>underline</string>
      </dict>
    </dict>
  </array>
</dict>
</plist>
]]

function M.generate(colors)
  return Util.template(template, colors)
end

return M
