#!/usr/bin/env python3 ;

word = input( "Enter a word!\n" ) ;
width = int( input( "Enter a width!\n" ) ) 
l = len( word )
output = ""
if l == 0:
   for i in range( 0 , width):
      output += '*'
else:
   left = ( width - l ) // 2
   for i in range(0 , left ):
      output += '*'
   output += word
   for i in range(0 , width - l - left ):
      output += '*'
print( output )      
