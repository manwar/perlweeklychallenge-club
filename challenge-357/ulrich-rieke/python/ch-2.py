#!/usr/bin/env python3
import math

def reduceFraction( numerator , denominator):
   smallest = math.gcd( numerator , denominator )
   if smallest == 1:
      return ( numerator , denominator)
   else:
      return ( numerator // smallest , denominator // smallest )

numberline = input( "Enter a positive integer!\n") 
number = int( numberline )
tuples = []
for num in range(1 , number + 1):
   for denom in range( 1 , number + 1):
      tup = ( num / denom , num , denom )
      tuples.append( tup )
orderedList = sorted(tuples ,  key=lambda x: x[0])
conv = map( lambda x: reduceFraction( x[1] , x[2] ) , orderedList )
converted = list( conv )
output = []
for c in converted:
   output.append( str( c[0] ) + "/" + str( c[1] )) 
result = []
for s in output:
   if s not in result:
      result.append( s )
print( result )   
