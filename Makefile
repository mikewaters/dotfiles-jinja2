.PHONY: macbook check uninstall install compile init clean

macbook: compile
	stow git

VENV := ./.virtualenv

# Ensure our dependencies are installed
check:
	@which stow

# Create a virtualenv into which we will install python dependencies
install: check
ifeq ($(shell which python3),)
	@virtualenv $(VENV)
else
	@pyvenv $(VENV)
endif
	@source $(VENV)/bin/activate && pip install yasha yamlreader
	@source $(VENV)/bin/activate && which yasha
	@source $(VENV)/bin/activate && which yamlreader

# Remove virtualenv, which will essentially uninstall the python dependencies
uninstall:
	rm -rf $(VENV)
	
TEMPLATES = $(shell find . -name "*.j2" -not -path "$(VENV)/*")
RENDERED = $(shell find . -name "*.j2" -not -path "$(VENV)/*" |sed 's/.j2//')
KERNEL = $(shell uname -s)

# Merge template config files (secret and non); note that the yamlreader merge will
# use whichever file specified last in the cli as the winner of duplicates.
# Render all of the jinja templates in the project, excepting for the virtualenv created to
# store our dependencies
compile:
	$(eval VARFILE = $(shell mktemp -t XXXXXX.yaml))
	@source $(VENV)/bin/activate && yamlreader environment.yaml secrets.yaml > $(VARFILE) 
	@$(foreach f, ${TEMPLATES}, \
		echo rendering $f; \
		source $(VENV)/bin/activate && yasha -v $(VARFILE) --kernel=$(KERNEL) $f; \
	)
	@rm -f $(VARFILE)

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

