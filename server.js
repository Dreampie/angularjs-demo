/**
 * Created by Dreampie on 15/7/1.
 */

var http = require('http');
var fs = require('fs');

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  //res.('index');
  fs.createReadStream('src/index.html').pipe(res);
}).listen(9000, '127.0.0.1');