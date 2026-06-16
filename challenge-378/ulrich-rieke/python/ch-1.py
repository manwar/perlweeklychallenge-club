#!/usr/bin/env python3

word = input( "Enter an alphanumeric string!\n")
digits = []
for c in word:
   if c.isnumeric( ):
      n = int( c )
      if n not in digits:
         digits.append( n )
l = len( digits )
if l == 0 or l == 1:
   print( -1)
else:
   sortedNums = sorted( digits )
   print( sortedNums[-2] )
