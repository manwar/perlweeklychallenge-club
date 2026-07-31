#!/usr/bin/env python3

def convert( number , base):
   conversions = {}
   for i in range( 0 , 10):
      conversions[i] = chr( i + 48 )
   for i in range( 10 , 37 ):
      conversions[i] = chr( i + 55 )
   for i in range( 37 , 64):
      conversions[i] = chr( i + 61 )
   conversions[64] = '+'
   conversions[65] = '/'
   converted = ""
   while number != 0:
      converted += conversions[number % base]
      number //= base
   result = converted[-1::-1]
   return result

line = input( "Enter a number and a base!\n" )
(numberpart , basepart) = line.split( ' ' )
number = int( numberpart )
base = int( basepart )
print( convert( number , base ))   
