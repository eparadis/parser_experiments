var PEG = require('pegjs');
var fs = require('fs');

fs.readFile('basic.pegjs', 'utf8', function(err,data) {
  if( err) {
    return console.log(err);
  }
  var parser = PEG.buildParser( data);

  fs.readFile('basic.input', 'utf8', function( innererr, innerdata) {
    try {
      var result = parser.parse(innerdata);
    }
    catch( e) {
      var result = e 
    }

    console.log( result);
  });
});

