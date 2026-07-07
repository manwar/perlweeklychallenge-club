#!/usr/bin/env python3

line = input( "Enter some integers separated by blanks!\n" ) 
numbers = [int(w) for w in line.split( ' ' )]
if len( numbers ) < 3:
   print( 0 )
else:
   selected = []
   for n in numbers:
      if any( a < n for a in numbers ) and any( b > n for b in numbers):
         selected.append( n )
   print( len( selected ) )         
