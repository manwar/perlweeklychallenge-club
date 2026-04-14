#!/usr/bin/env python3

line = input( "Enter a string , a size and a filler separated by blanks!\n")
(string , sizeString , fillstr ) = line.split( ' ' )
size = int( sizeString )
filler = fillstr[0]
output = []
start = 0
l = len( string ) 
while start < l:
   if start + size < l:
      output.append( string[start:start + size] )
   else:
      output.append( string[start:] )
   start += size
lastWord = output[-1]
ll = len( lastWord )
if ll < size:
   lastWord += filler * ( size - ll )
   output.pop( )
   output.append( lastWord )
print( output )   

