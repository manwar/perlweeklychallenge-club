#!/usr/bin/env python3 

def createNeighbours( vector , length):
   allNeighbours = []
   for start in range(0 , len( vector ) - length + 1):
      neighbours = []
      for i in range( start , start + length ):
      	  neighbours.append( vector[i] )
      allNeighbours.append( neighbours ) 
   return allNeighbours

source = []
line = input( "Enter some integers , <return> to end!\n" ) 
while line:
   row = []
   for w in line.split( ' ' ):
      row.append( int( w ) ) 
   source.append( row )
   line = input( "Enter some integers , <return> to end!\n" )
target = []
targetline = input( "Enter some integers to denote the target!\n" ) 
for w in targetline.split( ' ' ):
   target.append( int( w ) ) 
totallen = 0
for v in source:
   totallen += len(v) 
if totallen != len(target):
   print( "False" )
else:
   results = []
   for sublist in source:
      neighbours = createNeighbours( target , len(sublist))
      results.append( sublist in neighbours )
   print( all( results ) )
