#!/usr/bin/env python3

numberline = input( "Enter some numbers separated by blanks!\n" ) 
singlewords = numberline.split( ' ' )
numbers = []
for word in singlewords:
   numbers.append( float( word ) )
numbers.sort( ) 
differences = []
for i in range( 1 , len( numbers ) ):
    differences.append( numbers[i] - numbers[i - 1] )
print( all ( ele == differences[0] for ele in differences ) )    
