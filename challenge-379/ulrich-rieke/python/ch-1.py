#!/usr/bin/env python3

sentence = input( "Enter a string!\n" )
current = len( sentence )
if current == 0:
   print( "\"\"" )
else:
   reverseString = ""
   current -= 1
   while current != - 1:
      reverseString += sentence[current]
      current -= 1
   print( reverseString )
