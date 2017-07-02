.PHONY: docs


all:
	@echo "🚜  Booting up server"
	@stack build && stack exec server

docs:
	@echo "📖  Generating documentation"
	@stack build && stack exec docs
