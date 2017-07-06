.PHONY: cli docs


all: server

server:
	@echo "🚜  Booting up server"
	@stack build --exec server

docs:
	@echo "📖  Generating documentation"
	@stack build --exec docs

cli:
	@echo "🛠  Command-line"
	@stack build && stack exec cli $(filter-out $@,$(MAKECMDGOALS))

%:
	@:
