#!/usr/bin/env python3

word = input( "Enter a string!\n" )
value = 0 
pos = 1 
for c in word:
   value += pos * ( 123 - ord( c ) )
   pos += 1
print( value )   
