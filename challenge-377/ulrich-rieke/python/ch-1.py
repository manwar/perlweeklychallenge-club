#!/usr/bin/env python3

word = input( "Enter a word!\n" ) 
forward_pairs = []
l = len( word )
for p in range( 0 , l - 1):
   forward_pairs.append( word[p:p + 2] )
backword = word[l - 1::-1]
backward_pairs = []
for p in range( 0 , l - 1 ):
   backward_pairs.append( backword[p:p + 2] ) 
result = any( x in backward_pairs for x in forward_pairs )
print( result )   
