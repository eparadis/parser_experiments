
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
 = print_argument ( comma_separator print_argument)*

print_argument
 = quoted_string
 / integer

comma_separator
 = ws* "," ws*

ws
 = " "

eol
 = "\n"

quoted_string
 = '"' quoted_inner  '"'

quoted_inner
 = [a-z0-9 ]*
