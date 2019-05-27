setup:
	npm init -y
	npm install typescript --save-dev
	npm install @types/node --save-dev
	npx tsc --init

test: compile
	npx jest

clean:
	rm -r build

compile:
	tsc

help:
	@echo "## Install Dependencies"
	@echo "npm install <name>"
	@echo "npm install --save-dev <name>"

