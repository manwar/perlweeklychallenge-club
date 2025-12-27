#!/usr/bin/env python3
import re

codes = []
names = []
status = []
p = re.compile( r'^\w+$' ) 
result = []
codeline = input( "Enter some codes separated by whitespace!\n" )
for w in codeline.split( ' '):
    codes.append( w )
namesline = input( "Enter names from the given categories!\n" )
for w in namesline.split( ' ' ):
    names.append( w ) 
statusline = input ( "Enter as many true or false as codes!\n" ) 
for w in statusline.split( ' ' ):
    status.append( w ) 
categories = ["electronics" , "grocery" , "pharmacy" , "restaurant"]
for i in range(0 , len( codes )):
    m = p.match( codes[i] )
    if m and names[i] in categories and status[i] == "true":
        result.append( "true" )
    else:
        result.append( "false" )
print( result )        
      
