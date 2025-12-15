#!/usr/bin/env python3

numberline = input( "Enter some numbers separated by blanks!\n" ) ;
numbers = [] 
for w in numberline.split( ' ' ):
    numbers.append( float( w ) ) 
if (all( ele == numbers[0] for ele in numbers )):
    print( 0 )
else:    
    maxi = max( numbers )
    mini = min( numbers )
    numbers.remove( maxi )
    numbers.remove( mini ) 
    print( sum( numbers ) / len( numbers ))    
