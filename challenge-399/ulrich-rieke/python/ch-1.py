#!/usr/bin/env python3

def findSubstrings( word , k):
   substrings = []
   l = len( word )
   for start in range( 0 , l - k + 1):
      for upto in range( start + k , l + 1 ):
         substrings.append( word[start:upto] )
   return substrings 

def findFrequencies( word ):
   frequencies = {}
   for letter in word:
      if letter in frequencies.keys( ):
         frequencies[letter] += 1
      else:
         frequencies[letter] = 1
   return frequencies

def assessFrequencies( freq ):
   maximum = max( freq.values( ) )
   total = 0
   for k , v in freq.items( ):
      if v != maximum:
         total += v
   return (maximum , total)

line = input( "Enter a word in capital letters and a positive number k!\n")
elements = line.split( ' ' )
word = elements[0]
k = int( elements[1] )
wordfreqs = findFrequencies( word )
l = len( word )   
if len( wordfreqs ) == 1:
   print( l )
elif len( wordfreqs ) == l:
   print( k + 1 )
else:
   allSubstrings = findSubstrings( word , k )
   allFrequencies = [findFrequencies( w ) for w in allSubstrings]
   assessed = [assessFrequencies( f ) for f in allFrequencies]
   selected = [p for p in assessed if p[1] == k]
   mySorted = sorted( selected , key=lambda pair: pair[0] )
   le = len( mySorted )
   print( mySorted[le - 1][0] + mySorted[le - 1][1] )
