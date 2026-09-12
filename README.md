# Minimal-Nvim

A Neovim config built on `vim.pack`. No plugin manager, no bootstrap script.

Needs Neovim 0.13-dev.

## Dependencies

```sh
paru -S --needed git fzf ripgrep tree-sitter-cli zoxide wl-clipboard \
  lua-language-server bash-language-server pyright ruff \
  typescript-language-server stylua shfmt prettier
```

A Nerd Font is needed for icons. `zoxide` and `wl-clipboard` are optional.

## Install

Back up an existing config first:

```sh
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
```

Then:

```sh
git clone https://github.com/JuicyGoose007-coder/minimal-nvim ~/.config/nvim
nvim
```

First launch clones the plugins and builds treesitter parsers. Restart after.

## Plugins

| Plugin                 |                                              |
| ---------------------- | -------------------------------------------- |
| gruvbox-material       | colorscheme                                  |
| nvim-treesitter        | syntax highlighting and code parsing         |
| mini.icons             | file and language icons                      |
| mini.pairs             | auto-close brackets and quotes               |
| mini.visits            | harpoon-style file pinning and frecency      |
| fzf-lua                | fuzzy finder (files, grep, symbols, etc.)    |
| oil.nvim               | file explorer — edit directories as buffers   |
| undotree               | visual undo history                          |
| gitsigns.nvim          | git hunk signs, stage, blame, diff           |
| conform.nvim           | format-on-save (stylua, shfmt, prettier, etc.) |
| blink.cmp              | completion engine                            |
| which-key.nvim         | keymap popup on leader press                 |
| lazydev.nvim           | lua_ls support for neovim plugin APIs        |
| snacks.nvim            | dashboard, notifier, word refs, indent guides |
| trouble.nvim           | diagnostics, quickfix, symbols panel         |
| flash.nvim             | jump and treesitter-select motions           |
| vim-tmux-navigator     | `<C-h/j/k/l>` pane switching with tmux      |
| tiny-cmdline.nvim      | floating command line                        |
| treesj                 | split / join code blocks                     |
| nvim-hlslens           | match count overlay on search                |

## Keymaps

Leader is `<Space>`. `<leader>?` lists the current buffer's keys.

| Key                                        |                                                             |
| ------------------------------------------ | ----------------------------------------------------------- |
| `<leader>f`                                | find files                                                  |
| `<leader>g`                                | live grep                                                   |
| `<leader>*`                                | grep word under cursor                                      |
| `<leader>/`                                | search this file                                            |
| `<leader>z`                                | jump to project                                             |
| `<leader>sb` `sr` `sh` `sk` `ss` `sd` `sl` | buffers, recent, help, keymaps, symbols, diagnostics, lines |
| `<leader>sF` `sG`                          | files / grep from home                                      |
| `-` / `<leader>e`                          | oil, parent dir / float                                     |
| `s` / `S`                                  | flash jump / treesitter select                              |
| `<leader>1-4`                              | jump to pinned slot                                         |
| `<leader>v1-4`                             | pin file to slot                                            |
| `<leader>vd`                               | unpin current file                                          |
| `<leader>vv` `vV`                          | visited files (project / everywhere)                        |
| `]c` `[c`                                  | next / prev hunk                                            |
| `<leader>hs` `hr` `hp` `hb` `hd`           | stage, reset, preview, blame, diff hunk                     |
| `gd`                                       | go to definition                                            |
| `]]` `[[`                                  | next / prev reference                                       |
| `<leader>xx` `xX` `xq` `xl`                | diagnostics project, buffer, quickfix, loclist              |
| `<leader>cs` `cf`                          | symbols, format                                             |
| `<leader>m` `M`                            | split / join node, recursive                                |
| `U` / `<leader>U`                          | redo / undo tree                                            |
| `<A-j>` `<A-k>`                            | move line or selection                                      |
| `<S-h>` `<S-l>`                            | prev / next buffer                                          |
| `<leader>rw`                               | replace word under cursor                                   |
| `<leader>D`                                | delete to void                                              |
| `<leader>w` `q` `u` `R`                    | write, quit, update plugins, restart                        |
| `<leader>n` `N`                            | notification history, dismiss                               |

Completion is blink.cmp on the `default` preset: `<C-n>`/`<C-p>` move, `<C-y>`
accepts, `<Tab>` accepts or opens the menu, `<C-e>` takes the ghost text.

`<C-h/j/k/l>` are used by vim-tmux-navigator for pane switching. `<C-b>` and
`<C-k>` are left unmapped — my multiplexer eats them.
