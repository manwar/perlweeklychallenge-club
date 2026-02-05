#!/usr/bin/env python3

def findPair( number ):
   if number < 10:
      return (0 , number)
   else:
      root = number
      persistence = 0 
      while root > 9:
         digits = []
         while root != 0:
            digits.append( root % 10 )
            root //= 10
         persistence += 1
         root = sum( digits) ;
      return (persistence , root)  

number = input( "Enter a positive number!\n" ) 
num = int( number ) ;
result = findPair( num ) 
print( "Persistence  = " , result[0])
print( "Digital root = " , result[1] )
