# Minimal-Nvim

A Neovim config built on `vim.pack`. No plugin manager, no bootstrap script.

Needs Neovim 0.13-dev.

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

Dependencies:

```sh
yay -S neovim-git git fzf ripgrep tree-sitter-cli zoxide wl-clipboard \
  lua-language-server bash-language-server pyright ruff \
  typescript-language-server stylua shfmt prettier
```

A Nerd Font is needed for icons. `zoxide` and `wl-clipboard` are optional.

## Keymaps

Leader is `<Space>`. `<leader>?` lists the current buffer's keys.

| Key | |
| --- | --- |
| `<leader>f` | find files |
| `<leader>g` | live grep |
| `<leader>*` | grep word under cursor |
| `<leader>/` | search this file |
| `<leader>z` | jump to project |
| `<leader>sb` `sr` `sh` `sk` `ss` `sd` `sl` | buffers, recent, help, keymaps, symbols, diagnostics, lines |
| `-` / `<leader>e` | oil, parent dir / float |
| `]c` `[c` | next / prev hunk |
| `<leader>hs` `hr` `hp` `hb` `hd` | stage, reset, preview, blame, diff hunk |
| `gd` | go to definition |
| `]]` `[[` | next / prev reference |
| `<leader>xx` `xX` `xq` `xl` | diagnostics project, buffer, quickfix, loclist |
| `<leader>cs` `cf` | symbols, format |
| `U` / `<leader>U` | redo / undo tree |
| `<A-j>` `<A-k>` | move line or selection |
| `<S-h>` `<S-l>` | prev / next buffer |
| `<leader>rw` | replace word under cursor |
| `<leader>D` | delete to void |
| `<leader>w` `q` `u` `R` | write, quit, update plugins, restart |
| `<leader>n` `N` | notification history, dismiss |

Completion is blink.cmp on the `default` preset: `<C-n>`/`<C-p>` move, `<C-y>`
accepts, `<Tab>` accepts or opens the menu, `<C-e>` takes the ghost text.

`<C-h/j/k/l>`, `<C-b>` and `<C-p>` are left unmapped — my WM and multiplexer
eat them. Free to use if yours don't.
