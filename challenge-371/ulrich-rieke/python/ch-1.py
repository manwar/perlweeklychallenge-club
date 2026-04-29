#!/usr/bin/env python3

def find_missing( letters ):
   diffs = []
   l = len( letters )
   for i in range(1 , l ):
      if letters[i] != '?' and letters[i - 1] != '?':
         diffs.append( ord( letters[i] ) - ord( letters[i - 1] ) )
   question_pos = letters.index( '?' ) 
   uniques = set( letters ) 
   if len( uniques ) == 1:
      if question_pos == 0:
         return chr( ord( letter[1]) - diffs[0] ) 
      else:
         return chr( ord( letter[question_pos - 1] ) + diffs[0] )
   else:
      newdiffs = []
      for i in range( 0 , 2 ):
         newdiffs.append( diffs[0] ) 
         newdiffs.append( diffs[1] )
      if question_pos == 0:
         return chr( ord( letters[1] ) - newdiffs[0] ) 
      else:
         return chr( ord( letters[ question_pos - 1] ) + newdiffs[question_pos - 1] )

print( find_missing( ['a' , 'c' , '?' , 'g' , 'i'] ) )
print( find_missing( ['a' , 'd' , '?' , 'j' , 'm'] ))
print( find_missing( ['a' , 'e' , '?' , 'm' , 'q'] ))
print( find_missing( ['a' , 'c' , 'f' , '?' , 'k'] ) )
print( find_missing( ['b' , 'e' , 'g' , '?' , 'l'] ))
