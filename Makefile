.PHONY: fmt
fmt:
	@find . -type f -name "*.lua" -exec stylua --check --output-format Summary {} + -print
