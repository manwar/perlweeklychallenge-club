#!/usr/bin/env python3

numberstring = input( "Enter a numberstring!\n")
number = int( numberstring )
kvalue = input( "Enter a k value!\n" )
k = int( kvalue )
l = len( numberstring )
result = 0   
if k == l:
   result = 1
elif k > l:
   result = 0
else:
   numberstrings = []
   for pos in range( 0 , l - k + 1 ):
      numberstrings.append( numberstring[ pos:pos + k ])
   numbers = [int( ns ) for ns in numberstrings]
   selected = [num for num in numbers if number % num == 0]
   result = len(selected)
print( result )      
