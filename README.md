# NeoVim Config

NeoVim configuration for Linux, MacOS, and Windows. Based off of [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to add any additional customizations.

## Install and Setup

Download the latest release of the [omnisharp-roslyn](https://github.com/OmniSharp/omnisharp-roslyn/releases) lsp and extract it into the `~/.local/bin/omnisharp` directory. Make sure to give the files in the directory executable permissions (`chmod 744`).

## Features

- Colorschemes via [catppuccin](https://github.com/catppuccin/nvim).
- Markdown writing and previewing via [vim-markdown](https://github.com/preservim/vim-markdown) and [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim).
- AI code completion via [Copilot](https://github.com/copilot).
- LSP and debugging support for:
  - Dotnet/C# via [omnisharp-roslyn](https://github.com/OmniSharp/omnisharp-roslyn) and [netcoredbg](https://github.com/Samsung/netcoredbg)
  - Typescript/JavaScript via [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server)

## Keymaps

Using the built-in keymaps from [LazyVim](https://www.lazyvim.org/keymaps) with noted exceptions below.

`<leader>` is set to a single space. Pressing the leader key with a delay will show a browsable shortcut menu.

#### General

| Shortcut   | Mode   | Description            |
| ---------- | ------ | ---------------------- |
| <leader>jk | Insert | Escapes to normal mode |
| <C-a>      | Normal | Select all             |

#### Searching

| <leader>fr | Normal | Fuzzy find recent files |
| <leader>fs | Normal | Fuzzy find text |
| <leader>fc | Normal | Fuzzy find text under cursor |

#### Markdown (.md files only)

| Shortcut   | Mode   | Description                                    |
| ---------- | ------ | ---------------------------------------------- |
| <leader>mp | Normal | Opens a preview of current file in the browser |

## Debugging

### Dotnet

To start a debugging session, use `<leader>gc`. You will be prompted for the path to the project's `.csproj` file and also the path to the built `.dll` file. Unless I figure out a way around it, you will need to start nvim as root to have permissions to attach to the process. To retain the current user's nvim setup when using sudo, use `sudo -Es nvim`.
