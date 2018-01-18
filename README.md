# dotfiles

## Dependencies
gnu stow
mush

## Set up the project
This project needs to be in a child directory of ~ in order to stow to function in the default manner.
All commands need to be run inside this directory (presumably, ~/dotfiles).

`make initialize`

1. Compiles the moustache templates
2. Uses GNU stow to bootstrap the stow dotfiles; this will instruct it to ignore moustache templates.

Make target `compile` exists to recompile templates; changes will be automatically available for installed packages (as they are symlinks to the files you are changing).

## Install packages

`stow <package>`

## Uninstall packages

`stow -D <package>`

## Remove our stow customizations

`stow -D stow`
