{
  function noUndef(z) { return z != undefined; };
}

start 
 = line+

line
 = line_number command

line_number
 = number:integer ws { return number; }

integer "integer"
 = digits:[0-9]+ { return parseInt(digits.join(""), 10); }

command
 = cmd:(print_command eol) { return cmd[0]; }

print_command
 = "PRINT" ws guts:print_arguments { return guts.join(''); }
 / x:("PRINT") { return "\n"; }

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
