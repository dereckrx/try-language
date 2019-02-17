# Runs with node instead of browser
hello:
	elm make helloWorld.elm --output output/helloWorld.js
	node output/helloWorld.js

# This can be imported into an html file
js:
	elm make Main.elm --output output/app.js
	open index.html

html:
	elm make Main.elm --output output/index.html
	open output/index.html

# http://localhost:8000
start:
	elm reactor