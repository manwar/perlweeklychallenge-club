#!/usr/bin/env python3

def isAlternating( word ):
   evenpairs = []
   oddpairs = []
   vowels = "aeiou"
   number = 0
   evenvals = []
   oddvals = []
   for c in word:
      if number % 2 == 0:
         evenpairs.append( c )
      else:
         oddpairs.append( c )
      number += 1
   if word[0] in vowels:
      evenvals = [c in vowels for c in evenpairs]
      oddvals = [c not in vowels for c in oddpairs]
   else:
      evenvals = [c not in vowels for c in evenpairs]
      oddvals = [c in vowels for c in oddpairs]
   return all( evenvals ) and all( oddvals )

def allSubstrings( word ):
   l = len(word)
   substrings = []
   for start in range( 0 , l):
      for end in range( start + 1 , l + 1):
         substrings.append( word[start:end] )
   return substrings

def findCommon( wordlist ):
   firstSubstrings = allSubstrings( wordlist[0] )
   secondSubstrings = allSubstrings( wordlist[1] ) 
   thirdSubstrings = allSubstrings( wordlist[2] )
   allCommon = [w for w in firstSubstrings if (w in secondSubstrings and w in \
               thirdSubstrings)]
   return allCommon

line = input( "Enter some strings with English alphabetic characters only!\n" )
words = line.split( ' ' )
common = findCommon( words )
if len( common ) > 0:
   selected = [w for w in common if isAlternating( w )]
   if len( selected ) > 0:
      mySorted = sorted( selected , key=len ) 
      solution = [w for w in mySorted if len( w ) == len( mySorted[-1])]
      print( solution )
   else:
      print( "()" )
else:
   print( "()" )
