#[ 
   Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl Weekly Challenge’. 
   Also print the number of times the character ‘e’ is found in the string. 
]#

import strutils, strformat

let 
    input = "Perl Weekly Challenge"
    countE= input.count("e")
    replaced = input.replace("e", "E")

echo &"'{replaced}' [{countE} replaced]"