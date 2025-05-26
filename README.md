## Get started

- Install Neovim (`brew install neovim`)
- Clone this repo under `~/.config`
- You are good to go 🎉

## Language Servers

- Command `:Mason`
- Select Items mentioned in the txt file

## Telescope (file/code search)

- Install `brew install ripgrep`
- Install `brew install fd`

## Copilot

In order to use copilot, make sure to log into Github with an account with copilot enabled

- Command `:Copilot setup`
- Follow the instructions

## Vue support

If you wanted to support Vue, make sure to install vue-language-server with Mason. Also, npm registry should be set to `https://registry.npmjs.org/` to install the right package. 

## VS Code support

As it is Lazy Neovim based project, it automatically detects whether if the IDE is currently on VS Code or native NeoVim and thus it supports VS Code out of the box. If It is VS Code it would ignore plugins and apply key bindings using its package. 

## If something doesn't work

- `:checkhealth [PACKAGE_NAME]`
