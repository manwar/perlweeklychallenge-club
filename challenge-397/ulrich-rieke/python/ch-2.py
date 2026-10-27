#!/usr/bin/env python3
from functools import cmp_to_key

def toReversedBinary( number ):
   binaries = []
   while number != 0:
      binaries.append( number % 2 )
      number //= 2 ;
   return binaries

def toNumber( binaries ):
   total = 0
   arraylen = len( binaries )
   multiplier = 2 ** ( arraylen - 1 )
   for n in binaries:
      total += n * multiplier
      multiplier //= 2 ;
   return total

def convert( number ):
   binaries = toReversedBinary( number )
   reflected = toNumber( binaries )
   return reflected 

def mySorter( firstNumber , secondNumber):
   convA = convert( firstNumber )
   convB = convert( secondNumber )
   if convA != convB:
      if convA < convB:
         return -1
      else:
         return +1
   else:
      if firstNumber < secondNumber:
         return -1
      else:
         return +1
   
numberline = input( "Enter some integers separated by blanks!\n" ) 
numbers = [int( w ) for w in numberline.split( ' ' )]
mySorted = sorted( numbers , key=cmp_to_key( mySorter ))
print( mySorted )   
