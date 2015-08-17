{
  function debug(text) { return; console.log('[' + text + ']'); };
  function noUndef(z) { return z != undefined; };
  function PRINT(x) { console.log(x); return undefined; };
  function GOTO(t) { debug('jumping to ' + t); return t; };
  function NOP() { debug('doing nothing'); return undefined; };
  function get_next_line_number(lines, current_line_number) {
    var line_numbers = [];
    for( var i=0; i<lines.length; i+=1) {
      line_numbers[i] = lines[i][0];
    }
    line_numbers.sort( function numeric_sort_asc(a,b) { return a-b; });

    for( var i=0; i<line_numbers.length; i+=1) {
      if( line_numbers[i] == current_line_number) {
        if( i == line_numbers.length - 1) {
          return -1;
        } else {
          return line_numbers[i+1];
        }
      }
    }
    return -1;
  }
  function execute_lines( lines) {
    var line_dict = {};
    for( var i=0; i<lines.length; i+=1) {
      line_dict[ lines[i][0] ] = lines[i][1];
    }
    var current_line_number = lines[0][0];
    var next_line_number = undefined;
    while( current_line_number != -1 ) {
      debug( '--looking up ' + current_line_number);
      debug( '  --result is a ' + line_dict[ current_line_number]);
      next_line_number = line_dict[ current_line_number]();
      if( next_line_number == undefined) {
        next_line_number = get_next_line_number(lines, current_line_number);
      }
      current_line_number = next_line_number;
    }
  }
}

start 
 = lines:line+ { return execute_lines(lines); }

line
 = line_number command

line_number
 = number:integer ws { return number; }

integer "integer"
 = digits:[0-9]+ { return parseInt(digits.join(""), 10); }

command
 = cmd:(print_command eol) { return cmd[0]; }
 / if_command
 / goto_cmd:(goto_command eol) { return goto_cmd[0]; }

goto_command
 = "GOTO" ws target:integer { return function() { return GOTO(target); }; }

if_command
 = "IF" cond:if_condition "THEN" then_clause:if_then_clause eol { return cond ? then_clause : NOP;}

if_condition
 = ws value:integer ws { return value == 0? true : false; } 

if_then_clause
 = ws pcmd:print_command { return pcmd; }
 / ws gcmd:goto_command { return gcmd; }

print_command
 = "PRINT" ws guts:print_arguments { return function(){ PRINT(guts.join(''));}; }
 / x:("PRINT") { return function(){ PRINT('\n'); }; }

print_arguments
 = args: (print_argument*) { return args.filter(noUndef); }

print_argument
 = comma_separator* ws* q:quoted_string ws* { return q; }
 / comma_separator* ws* i:integer ws* { return i; }

comma_separator
 = x:( "," ) { return undefined; }

ws
 = x:(" ") { return undefined; }

eol
 = x:"\n" { return undefined; }

quoted_string
 = '"' qi:quoted_inner  '"' { return qi; }

quoted_inner
 = word:[a-z0-9 ]* { return word.join(''); }
