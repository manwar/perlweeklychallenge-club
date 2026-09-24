#!/usr/bin/env python3

def condition( firstword , secondword ):
   selected = [c for c in firstword if c not in secondword]
   return (len( selected ) == len( firstword ) )

line = input( "Enter some strings separated by whitespace!\n" ) 
words = [w for w in line.split( ' ' )]
l = len( words ) ;
maxi = 0
for i in range( 0 , l - 1 ):
   for j in range( i + 1 , l ):
      if condition( words[i] , words[j] ):
         val = len( words[i] ) * len( words[j] ) 
         if val > maxi:
            maxi = val
print( maxi )         
