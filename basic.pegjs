
start 
 = line+

line
 = line_number ws command eol

line_number
 = integer

integer "integer"
 = digits:[0-9]+ { return parseInt(digits.join(""), 10); }

command
 = print_command 

print_command
 = "PRINT" ws print_arguments 
 / "PRINT"

print_arguments
 = quoted_string ( comma_separator quoted_string)*

comma_separator
 = ws* "," ws*

ws
 = " "

eol
 = "\n"

quoted_string
 = '"' quoted_inner  '"'

quoted_inner
 = [a-z ]*
