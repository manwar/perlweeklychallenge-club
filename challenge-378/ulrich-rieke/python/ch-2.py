#!/usr/bin/env python3

def toNumber( word ):
   numberstring = ""
   for c in word:
      n = ord( c ) - 97
      numberstring += str( n )
   return int( numberstring )

strings = input( "Enter some strings consisting of English letters a to j!\n" )
words = strings.split( ' ' ) 
numbers = [toNumber( w ) for w in words]
print( numbers[0] + numbers[1] == numbers[2] )
