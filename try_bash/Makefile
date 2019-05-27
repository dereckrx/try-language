.PHONY: test files

installTest:
	curl https://raw.githubusercontent.com/lehmannro/assert.sh/master/assert.sh --output ./deps/assert.sh

test:
	ROOT_DIR=. ./run_tests.sh

files:
	ROOT_DIR=. ./file_paths.sh