# meowsoot.nvim — task runner. No external build deps.

# Default recipe: list available tasks
default:
    @just --list

# Headless smoke-test: load the colorscheme, fail on errors
check:
    nvim --headless --noplugin -u NONE \
      --cmd 'set rtp+=.' \
      -c 'colorscheme meowsoot' \
      -c 'echo "ok"' \
      -c 'q'

# Regenerate external-tool themes and palette documentation from the live palette
extras:
    nvim --headless --noplugin -u NONE \
      --cmd 'set rtp+=.' \
      -c 'lua require("meowsoot.extras").setup()' \
      -c 'q'

# Format every Lua source file with stylua
fmt:
    stylua lua/ colors/

# Verify all Lua files are stylua-clean (non-zero exit if not)
check-fmt:
    stylua --check lua/ colors/

# Drop the compiled-highlights cache
cache-clean:
    rm -f "$(nvim --headless --noplugin -u NONE -c 'echo stdpath(\"cache\")' -c 'q' 2>&1 | tr -d '\r\n')/meowsoot.json"
