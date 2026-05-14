# sf-symbols.nvim

A lightweight Neovim plugin to search SF Symbols names with Telescope and insert or copy the selected symbol wrapped in double quotes.

It only stores and uses SF Symbols names.

## Features

- Telescope picker for SF Symbols.
- Fuzzy search by symbol name.
- Inserts the selected symbol at the cursor.
- Inserts symbols wrapped in double quotes.
- Copies the selected symbol to the clipboard with `<C-y>`.
- Simple static data source.
- Suitable for Swift `Image(systemName:)` usage.

## Requirements

- Neovim
- [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)

## Installation

### lazy.nvim

```lua
{
  "dfdezmonteiro/sf-symbols.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("sf-symbols").setup()
  end,
}
```

## Usage

Run:

```vim
:SFSymbols
```

Search for a symbol name and select it.

### Insert action

Press `<CR>` / `Enter` to insert the selected symbol at the current cursor position, wrapped in double quotes.

Example selected symbol:

```text
folder.fill
```

Inserted text:

```swift
"folder.fill"
```

Example usage in Swift:

```swift
Image(systemName: "folder.fill")
```

### Copy action

Press `<C-y>` to copy the selected symbol to the clipboard, also wrapped in double quotes.

Example selected symbol:

```text
folder.fill
```

Copied text:

```text
"folder.fill"
```

This action is available in both Telescope insert mode and normal mode.

## Recommended keymap

```lua
vim.keymap.set("n", "<leader>fs", function()
  require("sf-symbols").pick()
end, { desc = "SF Symbols" })
```

Alternative:

```lua
vim.keymap.set("n", "<leader>fs", "<cmd>SFSymbols<cr>", { desc = "SF Symbols" })
```

## Project structure

```text
sf-symbols.nvim/
├── .gitignore
├── LICENSE
├── README.md
├── stylua.toml
└── lua/
    └── sf-symbols/
        ├── init.lua
        ├── telescope.lua
        └── data.lua
```

## Files

### `lua/sf-symbols/init.lua`

Plugin entry point.

It registers the command:

```vim
:SFSymbols
```

It also exposes:

```lua
require("sf-symbols").pick()
```

### `lua/sf-symbols/telescope.lua`

Telescope picker.

Responsibilities:

- Load the SF Symbols list.
- Show all symbols in a Telescope picker.
- Allow fuzzy search.
- Insert the selected symbol at the cursor.
- Copy the selected symbol to the clipboard.
- Wrap inserted and copied symbols in double quotes.

### `lua/sf-symbols/data.lua`

Static data file containing SF Symbols names.

Expected format:

```lua
local M = {}

M.symbols = {
  "folder",
  "folder.fill",
  "square.and.pencil",
  "magnifyingglass",
}

return M
```

## Data source

The plugin expects a plain list of SF Symbols names.

Recommended source:

1. Open the official SF Symbols app.
2. Select all symbols.
3. Copy names.
4. Paste the names into `lua/sf-symbols/data.lua`.

Use only names.

## Limitations

This plugin is not a language server.

It does not validate:

- platform availability
- iOS/macOS version availability
- rendering mode
- variable color support
- localization
- symbol variants
- target SDK compatibility

It only searches, inserts, and copies SF Symbol names.

Use Xcode and Apple tooling for semantic validation.

## License

MIT
