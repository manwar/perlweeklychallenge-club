#!/usr/bin/env python3

def condition( binstring ):
   l = len( binstring ) 
   half = l // 2
   firsthalf = '0' * half
   secondhalf = '1' * half
   first = binstring[0:half]
   second = binstring[half:]
   return ( first == firsthalf and second == secondhalf ) or \
                   (first == secondhalf and second == firsthalf )

binary = input ( "Enter a binary string consisting of 0 and 1 only!\n" )
solution = []
l = len( binary )
for startpos in range( 0 , l - 1 ):
   for stringlen in range( 2 , l - startpos + 1, 2):
      inner = binary[startpos:startpos + stringlen]
      if condition( inner ):
         solution.append( inner )
         break 
print( solution )         
