#!/usr/bin/env python3

words = input( "Enter some positive integers separated by blanks!\n" )
numbers = [int( w ) for w in words.split( ' ' )]
selected = [n for n in numbers if n % 2 == 0 and n % 3 == 0]
if len( selected ) == 0:
   print( 0 )
else:
   average = sum( selected ) / len( selected ) ;
   print( round( average ) )
