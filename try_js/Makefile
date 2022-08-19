PATH  := node_modules/.bin:$(PATH)

test:
	node --experimental-modules **/patterns/*.js

# https://github.com/avajs/ava/blob/master/docs/03-assertions.md
ava:
	npm run --experimental-modules ava **/*.test.js

curr:
	npm run --experimental-modules ava patterns/effects.test.js