#!/usr/bin/env python3

sentence = input( "Enter some words separated by blanks!\n" )
words = sentence.split( ' ' )
length = len( words )
result = 0
for i in range( 0 , length - 1 ):
   for j in range( i + 1 , length ):
      first = words[i]
      second = words[j]
      fl = len( first )
      sl = len( second )
      if second[0:fl] == first and second[sl - fl:] == first:
         result += 1
print( result )      
