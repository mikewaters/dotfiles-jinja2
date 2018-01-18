check:
	@which mush
	@which stow

compile: check
	@for f in **/{.??,}*.ms; do \
		echo $$f "-->" $${f%???}; \
		cat $$f | mush > $${f%???};\
	done

initialize: compile
	stow -t ${HOME} --ignore ".*.ms" stow

