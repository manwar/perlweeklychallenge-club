#!/usr/bin/env python3

def toDigits( number ):
   digits = []
   while number != 0:
      digits.append( number % 10 )
      number //= 10 
   return digits

def fromList( digits ):
   mySum = digits[0] * 1000 + digits[1] * 100 + digits[2] * 10 + digits[3]
   return mySum

def findPair( number ):
   allDigits = toDigits( number ) 
   length = len( allDigits )
   if length < 4:
      for _ in range( 0 , 4 - length ):
         allDigits.append( 0 )
   rising = sorted( allDigits )
   falling = list(reversed( rising ))
   return ( fromList( falling ) , fromList( rising) )      

startnumber = input( "Enter a positive 4-digit number!\n" )
number = int( startnumber ) 
startdigits = toDigits( number )
result = [d == startdigits[0] for d in startdigits]
if all( result ):
   print( -1  )
else:
   count = 0
   while number != 6174:
      pair = findPair( number )
      count += 1
      number = pair[0] - pair[1]
   print( count )
