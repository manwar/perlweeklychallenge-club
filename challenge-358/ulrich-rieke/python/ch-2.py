#!/usr/bin/env python3

def convert( word , number):
   converted = ""
   for c in word:
      num = ord( c )
      shifted = num + number
      if shifted in range(65 , 91 ) or shifted in range( 97 , 123):
         converted += chr( shifted )
      if shifted in range(91 , 97):
         converted += chr( (shifted % 91) + 65 )
      if shifted > 122:
         converted += chr( (shifted % 123 ) + 97 )
   return converted

word = input( "Enter a word consisting of ASCII alphabetic characters only!\n" ) ;
numberline = input( "Enter a positive integer!\n" )
number = int( numberline ) 
print( convert( word , number ) )   
