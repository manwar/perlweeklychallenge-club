#!/usr/bin/env python3
import math
def isPrime( number ):
   if number == 0 or number == 1:
      return False
   elif number == 2:
      return True
   else:
      root = math.floor( math.sqrt( number ) )
      values = [number % n != 0 for n in range( 2 , root + 1)]
      return all( values )

word = input( "Enter a word with English alphabetic characters only!\n" )
ordinals = [ord( c ) for c in word]
total = 0
for n in ordinals:
   total += n
if isPrime( total ):
   print( 0 ) 
else:
   upperPrime = 0
   lowerPrime = 0
   current = total + 1
   while not isPrime( current ):
      current += 1
   upperPrime = current
   current = total - 1
   while not isPrime( current ):
      current -= 1
   lowerPrime = current   
   print( min( upperPrime - total , total - lowerPrime ))   
