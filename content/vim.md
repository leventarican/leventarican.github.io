+++
title = "vim and nvim"
date = 2023-12-19
+++

# About
This document gives an overview about nvim. 
The concepts here are also applicable for vim and partially for vi.
But I will mostly focus on nvim. But to keep it short and generall i will use vim. 

Originally there was `vi`, then `vim` came and finally neovim aka. `nvim` arrivied.

# Motivation
Why am I using in some cases vim?

Basically vim is installed by default on linux and mac - it's __everywhere__. So whenever we login to a machine we can start wird text editing.
My other main reason is that in vim I am more __focused__. Especially that I not need a mouse and completely navigate via keyboard. This is the so called vim motion.
And it's __fast__.

For me an alternative editor to vim (but with UI) are:
* scite (scintilla)
* vscode
* geany (based on scintilla)
* sublime

I used that editor's in the past to edit files from various formats. But none of them are fast as vim.

Another thing is that i usually done a lot of things in `console`. The reason for that are various. 
* The console is deterministic. 
* Text is universal. 
* Easy to automate.

One more thing is when editing text in any kind of program we navigate using usually with arrow keys. Pressing it several times.
Instead of hitting arrow keys several times we can invest time in vim shortcut's like `dw` - delete word right from cursor.

# Introduction
Now as mentioned vim is by default installed on your machine or server.
By hitting `vim` in console you are ready to code. 

Vim has by default vim has a file explorer `netrw`. 

When enriching with plugins it can even more.

You can even attach a language server (protocoll) so that code completion is possible. But in such cases i use IDE's like `intellij` or `eclipse`.

To keep the dependency less I used minimum plugins. The plugins should work for both `vim` and `nvim`.

# Configuration
The default vim is enough for editing text but with few plugins and colorscheme vim is more enriched.

Here I give the main plugins I use:
* `telescope`   - with this plugin you can filter files in your current working directy. So we can navigate fast in our current working directory.
* `lualine`     - give you a good overview in status line. Like which vim mode or git branch
* `nvim-treesitter` - parses your text as tree and gives you syntax highlighting.

To install the plugins I use nvim `packer`.

A short note here. `vim` works with `.vim` files `nvim` can also understand `.lua` files.
So when configuring `nvim` i prefer `.lua`.

Git repository: https://github.com/leventarican/nvim-config

# Cheatsheet

```
i           insert mode
ESC         normal mode
v           visual mode: mark

hjkl        left,down,up,right - for arrow keys you can remap in .vimrc

w           next word (or SHIFT+arrow-right)
b           back next word (or SHIFT+arrow-left)
0           jump to begin of line
CTRL+$      jump to end of line
u           undo change
dw          delete word right
db          delete word left

gg          jump to top file
SHIFT+gg    jump bottom file

CTRL+ww     change windows: tab, split, etc.

# in visual mode
SHIFT+v     mark lines
STRG+v      mark vertikal

# in normal mode
cc          copy line
p           pase line
dd          delete/cut line
y           copy
yy          copy line

# command mode with <:>
tab         completion menu :+tab (iterate pressing tab)

# clipboard: extern clipboard support can be an issue.

# in case not working install xclib on linux
# sudo apt-get install xclip

# and set clipboard settings in your vim lua script
# vim.opt.clipboard:append("unnamedplus")
SHIFT+CTRL+v    paste; works on some terminals

:tabnew     create new tab
:tabclose   close current tab
gt          navigate between tabs

# telescope (plugin)
CTRL+f      open file finder. Shortcut is manually remapped
CTRL+v      open file in vertical split
CTRL+t      open file in tab

# file explorer buildin: netrw
t           open file in tab window
:E          close window or manually remap to CTRL+e
%           create new file
d           create new directory
D           delete file
u           directory up
```
