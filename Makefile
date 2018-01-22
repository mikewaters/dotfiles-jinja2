.PHONY: macbook check uninstall install compile init clean

macbook: init
	stow test

VENV := ./.virtualenv

# Ensure our dependencies are installed
check:
	@which stow

# Create a virtualenv into which we will install python dependencies
install: uninstall check
ifeq ($(shell which python3),)
	@virtualenv $(VENV)
else
	@pyvenv $(VENV)
endif
	@source $(VENV)/bin/activate && pip install yasha
	@source $(VENV)/bin/activate && which yasha

# Remove virtualenv, which will essentially uninstall the python dependencies
uninstall:
	rm -rf $(VENV)
	
TEMPLATES = $(shell find . -name "*.j2" -not -path "$(VENV)/*")
RENDERED = $(shell find . -name "*.j2" -not -path "$(VENV)/*" |sed 's/.j2//')
KERNEL = $(shell uname -s)

# Render all of the jinja templates in the project, excepting for the virtualenv created to
# store our dependencies
compile:
	@$(foreach f, ${TEMPLATES}, \
		echo rendering $f; \
		source $(VENV)/bin/activate && yasha -v environment.yaml --kernel=$(KERNEL) $f; \
	)

# CAUTION: this is destructive, it is for development only.
# This will result in broken symlinks if you did not uninstall the package first
# with `stow -D`.  If you then try to recompile (`make compile`) and reinstall using 
# stow, stow will complain and you will manually need to unlink the original broken symlink.
clean:
	@$(foreach f, ${RENDERED}, \
		git clean -fX $f; \
	)

# List the templates in this project
list:
	@$(foreach f, ${TEMPLATES}, \
		echo $f; \
	)

# Initialize the project by using stow to bootstrap itself.
# The expectation is that a bare/unconfigured version of stow will be installed;
# if a configured version of stow *is* installed, we will overwrite its config files.
# Note: we pass -t param to stow here because, while the template render process populates
# the `--target` parameter in .stowrc with the user's home directory, .stowrc has
# not yet been symlinked to $HOME and therefore stow will, by default, symlink 
# .stowrc into pardir of the location of this projecat
# TODO: add ignore for yaml, in case I want to add variables for stowrc templating
init: compile
	@stow -t ${HOME} --ignore ".*.j2" stow

# deinitialize; this will j ust remove our stow configurations, it will not unlink any projects
# or delete any rendered templates
deinit:
	@stow -D stow
