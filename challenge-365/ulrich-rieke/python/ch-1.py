#!/usr/bin/env python3
def convert( word ):
   converted = ""
   for w in word:
      converted += str( ord( w ) - 96 )
   return int( converted )

def digitsum( number ):
   digiSum = 0 ;
   while number != 0:
      digiSum += number % 10 ;
      number //= 10 ;
   return digiSum

word = input( "Enter a word consisting of lowercase English letters only!\n" )
number = input( "Enter a positive integer!\n" ) 
k = int( number )
result = digitsum( convert( word ))
k -= 1
while k != 0:
   result = digitsum( result )
   k -= 1
print( result )   
