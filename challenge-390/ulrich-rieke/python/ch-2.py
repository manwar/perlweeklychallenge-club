#!/usr/bin/env python3

line = input( "Enter an alphabetic string and and integer!\n" )
parts = line.split( ' ')
startword = parts[0]
k = int( parts[1] )
if k == 1:
   transformations = []
   transformations.append( startword[1:] + startword[0] )
   while startword not in transformations:
      newword = transformations[-1][1:] + transformations[-1][0] 
      transformations.append( newword )
   mySorted = sorted( transformations )
   print( mySorted[0] ) 
else:
   letters = []
   for c in startword:
      letters.append( c )
   mySort = sorted(letters)
   solution = ""
   for c in mySort:
      solution += c
   print( solution )   
      
