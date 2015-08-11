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
      for( var i = 0; i < result.length; i += 1) {
        var line_number = result[i][0];
        var action = result[i][1];
        //console.log(line_number + ' ' +action.toString());
        action();
      }
    }
    catch( error) {
      var result = error
    }

    console.log( result);
  });
});

