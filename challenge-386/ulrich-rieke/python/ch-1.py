#!/usr/bin/env python3

def findTable():
   conversions = {}
   for i in range( 0 , 10):
      conversions[i] = chr( i + 48 )
   for i in range( 10 , 37 ):
      conversions[i] = chr( i + 55 )
   for i in range( 37 , 64):
      conversions[i] = chr( i + 61 )
   conversions[64] = '+'
   conversions[65] = '/'
   table = {}
   for k , v in conversions.items( ):
      table[v] = k
   return table

def convert( numberstring , base , table):
   result = 0
   multiplier = 1
   for c in numberstring[-1::-1]:
      factor = multiplier * table[c]
      result += factor
      multiplier *= base
   return result

numberstring = input( "Enter a numberstring in a given base!\n" ) ;
basestr = input( "Enter a base!\n" )
base = int( basestr )
table = findTable( )
print( convert( numberstring , base , table))   

