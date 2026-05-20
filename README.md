# sf-symbols.nvim

Search and insert Apple SF Symbols directly from Neovim.

`sf-symbols.nvim` lets you quickly search SF Symbol names and insert them into your buffer. It is useful when working with Swift, SwiftUI, iOS, macOS, visionOS, watchOS, tvOS, or any project where SF Symbol names are needed.

## Features

- Search SF Symbols from Neovim
- Insert the selected symbol name at the cursor position
- Copy the selected symbol name to the clipboard when supported by the active picker
- Optional quotes around inserted symbols
- Picker-agnostic architecture
- Supports:
  - Telescope
  - fzf-lua
  - snacks.nvim
  - `vim.ui.select`

## Requirements

- Neovim `0.9+`

Optional picker dependencies:

- [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)
- [`ibhagwan/fzf-lua`](https://github.com/ibhagwan/fzf-lua)
- [`folke/snacks.nvim`](https://github.com/folke/snacks.nvim)

If no supported picker is found, the plugin falls back to `vim.ui.select`.

## Installation

### lazy.nvim

```lua
{
  "dfdezmonteiro/sf-symbols.nvim",
  config = function()
    require("sf-symbols").setup({
      picker = "auto",
    })
  end,
}
```

With Telescope:

```lua
{
  "dfdezmonteiro/sf-symbols.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("sf-symbols").setup({
      picker = "telescope",
    })
  end,
}
```

With fzf-lua:

```lua
{
  "dfdezmonteiro/sf-symbols.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
  },
  config = function()
    require("sf-symbols").setup({
      picker = "fzf_lua",
    })
  end,
}
```

With snacks.nvim:

```lua
{
  "dfdezmonteiro/sf-symbols.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    require("sf-symbols").setup({
      picker = "snacks",
    })
  end,
}
```

## Configuration

Default configuration:

```lua
require("sf-symbols").setup({
  picker = "auto",
  insert_quotes = true,
})
```

Available options:

| Option          |      Type |  Default | Description                             |
| --------------- | --------: | -------: | --------------------------------------- |
| `picker`        |  `string` | `"auto"` | Picker backend to use                   |
| `insert_quotes` | `boolean` |   `true` | Insert symbols wrapped in double quotes |

Available picker values:

```lua
"auto"
"telescope"
"fzf_lua"
"snacks"
"vim_ui_select"
```

## Picker resolution

When using:

```lua
picker = "auto"
```

the plugin resolves the picker in this order:

1. `snacks`
2. `fzf_lua`
3. `telescope`
4. `vim_ui_select`

`vim_ui_select` is always available because it uses Neovim’s built-in `vim.ui.select`.

## Usage

Open the SF Symbols picker:

```vim
:SFSymbols
```

Use a specific picker for one call:

```vim
:SFSymbols telescope
:SFSymbols fzf_lua
:SFSymbols snacks
:SFSymbols vim_ui_select
```

Or from Lua:

```lua
require("sf-symbols").pick()
```

With a specific picker:

```lua
require("sf-symbols").pick({
  picker = "telescope",
})
```

## Keymaps

Example keymap:

```lua
vim.keymap.set("n", "<leader>ss", function()
  require("sf-symbols").pick()
end, {
  desc = "Search SF Symbols",
})
```

Example with a specific picker:

```lua
vim.keymap.set("n", "<leader>sS", function()
  require("sf-symbols").pick({
    picker = "fzf_lua",
  })
end, {
  desc = "Search SF Symbols with fzf-lua",
})
```

## Insert behavior

By default, selected symbols are inserted wrapped in double quotes.

For example, selecting:

```text
square.and.arrow.up
```

inserts:

```swift
"square.and.arrow.up"
```

This is useful for SwiftUI:

```swift
Image(systemName: "square.and.arrow.up")
```

To insert the raw symbol name without quotes:

```lua
require("sf-symbols").setup({
  insert_quotes = false,
})
```

Then selecting:

```text
square.and.arrow.up
```

inserts:

```text
square.and.arrow.up
```

## Copy behavior

Some picker backends support copying the selected symbol to the clipboard.

Default copy mapping:

```text
<C-y>
```

Supported by:

| Picker        | Insert | Copy |
| ------------- | -----: | ---: |
| Telescope     |    Yes |  Yes |
| fzf-lua       |    Yes |  Yes |
| snacks.nvim   |    Yes |  Yes |
| vim.ui.select |    Yes |   No |

`vim.ui.select` is intentionally minimal and does not provide portable custom key mappings.

## Examples

### SwiftUI

```swift
Image(systemName: "heart.fill")
```

```swift
Label("Share", systemImage: "square.and.arrow.up")
```

```swift
Button {
  // action
} label: {
  Image(systemName: "trash")
}
```

### Markdown notes

```md
- "checkmark.circle"
- "xmark.circle"
- "folder"
- "doc.text"
```

### Plugin development

```lua
local icon = "checkmark.circle"
```

## Commands

| Command                    | Description                  |
| -------------------------- | ---------------------------- |
| `:SFSymbols`               | Open the configured picker   |
| `:SFSymbols auto`          | Resolve picker automatically |
| `:SFSymbols telescope`     | Open with Telescope          |
| `:SFSymbols fzf_lua`       | Open with fzf-lua            |
| `:SFSymbols snacks`        | Open with snacks.nvim        |
| `:SFSymbols vim_ui_select` | Open with `vim.ui.select`    |

## Lua API

### `setup(opts)`

Configures the plugin.

```lua
require("sf-symbols").setup({
  picker = "auto",
  insert_quotes = true,
})
```

### `pick(opts)`

Opens the symbol picker.

```lua
require("sf-symbols").pick()
```

With options:

```lua
require("sf-symbols").pick({
  picker = "telescope",
})
```

## Recommended setup

For most users:

```lua
{
  "dfdezmonteiro/sf-symbols.nvim",
  config = function()
    require("sf-symbols").setup({
      picker = "auto",
      insert_quotes = true,
    })

    vim.keymap.set("n", "<leader>ss", function()
      require("sf-symbols").pick()
    end, {
      desc = "Search SF Symbols",
    })
  end,
}
```

## Notes

This plugin searches SF Symbol names. It does not render SF Symbols inside Neovim.

Availability of a specific SF Symbol may depend on the Apple platform version being targeted by your project. Always verify symbol availability in Apple’s official SF Symbols app or Apple documentation when targeting older iOS, macOS, watchOS, tvOS, or visionOS versions.

## License

MIT
