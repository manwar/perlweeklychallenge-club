#!/usr/bin/env python3 

numberstring = input( "Enter a string with numbers only!\n" ) 
charstring = input( "Enter a number character\n" )
number = charstring[0]
if numberstring[0] == number and number < numberstring[1]:
   numberstring = numberstring[1::]
else:
   pos = numberstring.rfind( number )
   if pos != -1:
      numberstring = numberstring[0:pos] + numberstring[pos + 1::] 
print( numberstring )      
