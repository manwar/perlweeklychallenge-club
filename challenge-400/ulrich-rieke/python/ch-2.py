#!/usr/bin/env python3

def string_difference( word1 , word2 ):
   l = len( word1 ) 
   mutations = 0
   for i in range(0 , l):
      if word1[i] != word2[i]:
         mutations += 1
   return mutations

start = input( "Enter a start genome!\n" )
end = input ("Enter an end genome of equal length!\n" )
bank = input( "Enter some genomes of equal length with start!\n" )
genes = bank.split( ' ' )
if start == end:
   print( 0 )
elif( end not in genes ):
   print( -1 )
else:
   mutations = string_difference( start , end )
   intermediate_diffs = [string_difference( s , start ) for s in genes]
   vals = [n in intermediate_diffs for n in range(1 , mutations + 1)]
   if all( vals ):
      print( mutations )
   else:
      print( -1 )
