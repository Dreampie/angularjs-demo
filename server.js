/**
 * Created by Dreampie on 15/7/1.
 */

var port = 9000;
var mime = {
  'htm': 'text/html',
  'html': 'text/html',
  'css': 'text/css',
  'gif': 'image/gif',
  'ico': 'image/x-icon',
  'jpg': 'image/jpeg',
  'js': 'text/javascript',
  'png': 'image/png',
  'rar': 'application/x-rar-compressed',
  'txt': 'text/plain',
  'json': 'text/plain',
  'jar': 'application/java-archive'
};
var dir = process.argv[2];
var root = dir ? dir : process.cwd();

var http = require('http');
var url = require('url');
var fs = require('fs');
var path = require('path');

var index = './index.html';

http.createServer(function (req, res) {
  var pathname = url.parse(req.url).pathname;
  var realpath = pathname !== '/' ? root + pathname : index;
  var extname = path.extname(realpath).slice(1);
  var contentType = 'text/html';

  if (extname && mime[extname]) {
    contentType = mime[extname];
  }

  fs.exists(realpath, function (exists) {
    if (exists) {
      res.writeHead(200, {'Content-Type': contentType});
      fs.createReadStream(realpath).pipe(res);
    } else {
      res.writeHead(200, {'Content-Type': contentType});
      fs.createReadStream(index).pipe(res);
    }
  });

}).listen(port);

console.log('simple static file server runing at port: ' + port + '.');