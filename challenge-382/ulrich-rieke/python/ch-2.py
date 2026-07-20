#!/usr/bin/env python3
from itertools import combinations

def replaceQuestionMarks( word , substitution):
   substituted = ""
   n = 0
   for letter in word:
      if letter != '?':
         substituted += letter
      else:
         substituted += substitution[n]
         n += 1
   return substituted

word = input( "Enter a word consisting of 0 , 1 and ? only!\n" )
l = word.count( '?' )
if l == 0:
   print( '(' + word + ')' )
else:
   possibleCombis = []
   for n in range( l ):
      possibleCombis.append( '0' )
      possibleCombis.append( '1' )
   allStrings = []
   for i in combinations( possibleCombis , l ):
      replaced = replaceQuestionMarks(word , i ) 
      if replaced not in allStrings:    
         allStrings.append(replaceQuestionMarks( word , i ))
   mySorted = sorted( allStrings )
   print( '(' + ','.join( mySorted ) + ')' )

