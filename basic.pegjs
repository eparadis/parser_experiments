{
  //var POINTER = 0;
  function noUndef(z) { return z != undefined; };
  function PRINT(x) { console.log(x); };
  function NOP() {};
  function SET_POINTER(value) { POINTER = value; };
  function execute_lines( lines) {
    for(var i=0; i< lines.length; i+=1) {
      var action = lines[i][1];
      action();
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
 = "GOTO" ws target:integer { return function(target){ SET_POINTER(target); }; }

if_command
 = "IF" cond:if_condition "THEN" then_clause:if_then_clause eol { return cond? then_clause : NOP;}

if_condition
 = ws value:integer ws { return value == 0? true : false; } 

if_then_clause
 = ws cmd:print_command { return cmd; }

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
