# Claude Desktop Swipe

Adds two-finger trackpad swipe navigation to Claude for Desktop: swipe right for Back and left for Forward. Claude has Back and Forward buttons and the `Cmd+[` / `Cmd+]` shortcuts, but no trackpad swipe navigation. This Hammerspoon module maps swipes to those shortcuts only while Claude is frontmost. It respects the macOS natural scrolling setting, leaves ordinary scrolling unblocked, and restarts its event tap if macOS disables it.

## Requirements

- macOS
- [Hammerspoon](https://www.hammerspoon.org/) (free)
- Accessibility permission for Hammerspoon in System Settings

## Install

Install Hammerspoon with Homebrew:

```sh
brew install --cask hammerspoon
```

Copy `claude-swipe.lua` to `~/.hammerspoon/`, then add this line to `~/.hammerspoon/init.lua`:

```lua
require("claude-swipe")
```

Reload the Hammerspoon configuration from its menu bar icon.

To download the module and append the `require` line only if it is missing, run:

```sh
mkdir -p ~/.hammerspoon && touch ~/.hammerspoon/init.lua && curl -fsSL https://raw.githubusercontent.com/bogdan0dzuba/claude-desktop-swipe/main/claude-swipe.lua -o ~/.hammerspoon/claude-swipe.lua && (grep -qxF 'require("claude-swipe")' ~/.hammerspoon/init.lua || printf '\nrequire("claude-swipe")\n' >> ~/.hammerspoon/init.lua)
```

Then reload the Hammerspoon configuration.

## Tuning

The module triggers after horizontal movement exceeds `120` px and is more than `2.5` times the vertical movement. Adjust `THRESHOLD` or the `2.5` ratio in `claude-swipe.lua` if needed.

## Troubleshooting

- Nothing happens: grant Hammerspoon Accessibility permission, then check its Console for errors.
- Direction is reversed: check the macOS natural scrolling setting; the module follows it.

## Uninstall

Remove `~/.hammerspoon/claude-swipe.lua` and the `require("claude-swipe")` line from `~/.hammerspoon/init.lua`, then reload the Hammerspoon configuration.

## Use with another app

Change `BUNDLE` in `claude-swipe.lua` to the other app's bundle identifier. Find it with:

```sh
osascript -e 'id of app "Name"'
```

This project is unofficial and is not affiliated with Anthropic.

## License

MIT. See [LICENSE](LICENSE).
