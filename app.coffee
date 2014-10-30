express = require('express')
app = express()
server = require('http').createServer(app)
fs = require('fs')
io = require('socket.io')(server)
bodyParser = require('body-parser')

app.use(bodyParser.urlencoded({ extended: false }))
app.use(require('express-ejs-layouts'));
app.use(require('express').static('public'));

app.set('view engine', 'ejs');

app.get '/', (req, res) ->
	fs.readdir 'code', (err, files) ->
		console.log (files)
		res.render "index", {files: files}


module.exports = server;
# if (!module.parent) 
#   	console.log('Server running on http://localhost:3000')
#   	http.listen(3000)