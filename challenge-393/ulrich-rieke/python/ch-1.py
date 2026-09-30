#!/usr/bin/env python3

numberstring = input( "Enter a positive integer!\n" )
number = int( numberstring )
total = 0 
for a in range( 1 , number + 1 ):
   for b in range( 1 , number + 1):
      for c in range( 1 , number + 1):
         if a ** 2 + b ** 2 == c ** 2:
            total += 1
print( total )         
