#!/usr/bin/env python3

def convert( word ):
   numbers = "0123456789"
   values = [w in numbers for w in word]
   if all(values):
      return int( word )
   else:
      return len( word )

line = input( "Enter some alphanumeric strings separated by blanks!\n")
allWords = []
for w in line.split( ' ' ):
   allWords.append( w ) 
allLens = [convert( wo ) for wo in allWords]
print( max( allLens ))    
