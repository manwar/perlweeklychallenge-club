#!/usr/bin/env python3

def find( posis , element):
   for p in posis:
      if p[1] == element:
         return p
   
orderline = input( "Enter some integers from 1 to n in any order!\n" )
friendline = input( "Enter a subset of integers in ascending order!\n" )
order = [int( w ) for w in orderline.split( ' ' )]
friends = [int( w ) for w in friendline.split( ' ' )]
positions = []
for i in range( 0 , len( order )):
   positions.append( i )
letterpositions = list( zip( positions , order ))
selected = [find( letterpositions , n) for n in friends]
mySorted = sorted( selected , key=lambda pair: pair[0] ) 
print( [p[1] for p in mySorted] )   
