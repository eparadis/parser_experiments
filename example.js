var PEG = require('pegjs');
var fs = require('fs');

fs.readFile('example.pegjs', 'utf8', function(err,data) {
  if( err) {
    return console.log(err);
  }
  var parser = PEG.buildParser( data);

  fs.readFile('example.input', 'utf8', function( innererr, innerdata) {
    var result = parser.parse(innerdata);

    console.log( result);
  });
});

