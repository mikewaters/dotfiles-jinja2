# dotfiles

Jinja2-templated dotfiles, deployed by stow.

A normal dotfiles repo that uses `GNU Stow` contains a set of directories, each
one containing one or more files that will be symlinked by Stow into your 
home directory.  

This project follows that model, with the addition of allowing the user to template
these files using `Jinja2`, in order to achieve dotfile sharing between operating
system variants (linux, bsd, osx).

## How it works
### Templates
Template files use the Jinja2 format, and should have the `.j2` extension appended to 
their filenames.  When the user is ready to install or update their dotfiles, they
run the make target `compile` which will render those template files, creating output
files named by removing the `.j2` suffix.
#### Template variables
Template variables are provided to the renderer in three ways; first, some are provided
automatically by the Makefile (kernel name); second, the user should populate the
`environment.yaml` file that can be checked into source control; third, the user can populate
a `secrets.yaml` file that should not be checked into source control (and is gitignored).
A sample file is provided.

### Stow
`GNU Stow`, given a directory of files (called a 'package'), can be instructed to symlink
one or more of those files into a given directory.  Stow can be configured to use a specific directory
(called a 'target') by using the cli or by modifying a `.stowrc` file.  `.stowrc` file can exist 
centrally in `${HOME}` and/or in an directory in which stow is invoked.  This project contains 
a `.stowrc` file that stow will automatically use, and in this file is both the target to be used
(home directory) as well as a rule telling it to ignore `*.j2` files (templates).  This `.stowrc` 
is actually a template, which is rendered by `make compile` in order to populate the path to the
user's home directory.

## Usage
### Installing the dependencies
gnu stow
python2 or 3
yasha (python library)
yamlreader (python library)

`make install` will install the python libraries.

### Setting up the project
This project can be located anywhere in the filesystem (typically, stow-based dotfiles projects need to
be located inside of ~, but this doesnt have that restriction).

`make compile`

Compiles the jinja2 templates, including the .stowrc which will instruct stow to always target $HOME and to ignore jinja2 templates


### Installing stow packages
Individual packages can be installed uisng stow.
`cd <path to this project>`
`stow <package>`

Alternatively, make targets can be used to group stow projects.
`cd <path to this project>`
`make macbook`

### Uninstalling packages

`stow -D <package>`

## Development
For any file that requires a variant, the file is templated using `Jinja2` and the
`.j2` extension is added to it.  Running `make build` will drop a .gitignore into each
stow package to prevent rendered files from being accidentally committed into source control. 
Running `make compile` will render all templates, allowing yo uto see if your template is working.
Make sure you don't stow these files until you are ready; if you stow something, and then modify
your package, for instance removing a file, un-stowing will NOT remove that file's symlink, as stow
doesnt know anything about it anymore.

For information on using Jinja filters and extensions, see the documentation for `yasha`, which is
the Jinja2 cli wrapper that this project uses to render templates.

## Issues
If you have a .j2 file that needs to be stowed, this will not work for you ;)
