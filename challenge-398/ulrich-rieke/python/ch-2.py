#!/usr/bin/env python3

def letter_differences( word ):
   differences = [] 
   for n in range( 1, len( word )):
      differences.append( ord( word[n] ) - ord( word[n - 1] ))
   return differences

def toString( somevector):
   output = ""
   for num in somevector:
      output += str( num )
      output += ','
   result = output[0:-1]
   return result

line = input( "Enter some words with equal length > 1!\n" )
allWords = [w for w in line.split( ' ' )]
word_diffs = {}
for w in allWords:
   word_diffs[w] = toString(letter_differences( w ))
difference_counts = {}
for v in word_diffs.values( ):
   if v in difference_counts.keys( ):
      difference_counts[v] += 1
   else:
      difference_counts[v] = 1 
solution = ""
for k , v in difference_counts.items( ):
   if v == 1:
      for word , diffs in word_diffs.items( ):
         if diffs == k:
            solution = word 
            break
print( solution )         
