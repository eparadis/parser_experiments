var PEG = require('pegjs');
var fs = require('fs');

fs.readFile('example.pegjs', 'utf8', function(err,data) {
  if( err) {
    return console.log(err);
  }
  var parser = PEG.buildParser( data);

  var result = parser.parse("2*(3+4)");

  console.log( result);
});

