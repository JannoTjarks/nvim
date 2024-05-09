.PHONY: fmt
fmt:
	@find . -type f -name "*.lua" -exec stylua {} + -print
