# dotfiles

Jinja2-templated dotfiles, deployed by stow.

A normal dotfiles repo that uses `GNU Stow` contains a set of directories, each
one containing one or more files that will be symlinked by Stow into your 
home directory.  Typically you must check out a stow-based dotfiles repo into
your home directory, because the default behavior of stow is to symlink into
the parent directory of cwd.  This can be overridden, and this project does perform that override.

In order to support variants of dotfiles, for instance varying-by operating system,
this project uses a templating language to allow expression of variants.

For any file that requires a variant, the file is templated using `Jinja2` and the
`.j2` extension is added to it.  At the same time, a .gitignore rule is added for the
rendered file's name (ex: bash/.bashrc.j2 would require bash/.bashrc in ignore list).
This prevents rendered fies from getting committed into source control, and also 
allows rendered files to be cleaned up by a script. This will be added to the project's 
build process.

The data for variants is driven by Jinja's capabilities; by default, we pass into the template layer
the current kernel (uname -s) as well as any data defined in `environment.yaml`.

## Dependencies
gnu stow
python2 or 3
yasha (python library)

`make install` will install the python libraries.

## Set up the project
This project can be located anywhere in the filesystem, as lonvg as you bootstrap it using our initializer.

`make init`

1. Compiles the jinja2 templates, including the .stowrc which will instruct stow to always target $HOME
2. Uses GNU stow to bootstrap the stow config files; this will instruct (in additon to --target=$HOME) it to ignore jinja2 templates.

Make target `compile` exists to recompile templates; changes will be automatically available for installed packages (as they are symlinks to the files you are changing).

## Install packages
Individual packages can be installed uisng stow.
`cd ~/dotfiles`
`stow <package>`

Alternatively, make targets can be used.
`make macbook`

## Uninstall packages

`stow -D <package>`

## Remove our stow customizations

`stow -D stow`

## Issues
We skip j2 and yaml files, they will not be stowed.  if this is an issue it can be worked aroun
