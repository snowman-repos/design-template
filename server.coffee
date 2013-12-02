# Module dependencies.
express = require('express')
path = require('path')
fs = require('fs')
app = express()


# Express Configuration
app.configure 'development', ->
	app.use require('connect-livereload')()
	app.use express.static(path.join(__dirname, 'public'))
	app.use express.errorHandler()

app.configure 'production', ->
	app.use express.favicon(path.join(__dirname, 'public', 'favicon.ico'))
	app.use express.static(path.join(__dirname, 'public'))

# Start server
port = process.env.PORT || 9000
app.listen port, ->
	console.log 'Express server listening on port %d in %s mode', port, app.get('env')