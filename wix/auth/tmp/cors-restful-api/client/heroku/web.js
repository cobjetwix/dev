var express = require('express'),
	modRewrite = require('connect-modrewrite');;

var app = express.createServer(express.logger());
app.use(modRewrite([
    '!\\.\\w+$ /'
 ]));
app.use(express.static(__dirname + '/dist'));

app.listen(process.env.PORT || 5000);