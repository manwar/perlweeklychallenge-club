#!/usr/bin/env python3 

def isRepeating( number ):
   if number > 9:
      digits = []
      uniques = set( )
      while number != 0:
         digits.append( number % 10 ) ;
         uniques.add( number % 10 ) 
         number //= 10 
      return len( uniques ) != len( digits )
   else:
      return False 

number = int( input( "Enter a positive integer!\n" ) )
selected = [n for n in range( 1, number + 1 ) if not( isRepeating( n ) )]
l = len( selected )
maxi = 0   
for i in range( 1 , l ):
   diff = selected[i] - selected[i - 1]
   if diff > maxi:
      maxi = diff
print( maxi )   
   
