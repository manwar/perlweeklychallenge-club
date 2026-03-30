#!/usr/bin/env python3

#motivated by the Haskell solution ...!!!
def rearrange( binary ):
   l = len( binary ) 
   ones = binary.count( '1' )
   return ('1' * ( ones - 1 )) + ('0' * ( l - ones )) + "1"

binary = input( "Enter a binary term with at least one 1!\n")
print( rearrange( binary ))
