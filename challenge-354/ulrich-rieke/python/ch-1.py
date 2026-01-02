#!/usr/bin/env python3

numberlist = input( "Enter some integers separated by blanks!\n") ;
numbers = []
for w in numberlist.split( ' ' ):
    numbers.append( int( w ) ) 
numbers.sort( )
length = len( numbers )    
neighbours = [[numbers[i] , numbers[j]] for i in range(0, length - 1) for j in
range(i + 1 , length)]
differences = [p[1] - p[0] for p in neighbours]
mindiff = min( differences )
selected = filter( lambda p : p[1] - p[0] == mindiff , neighbours)
print( list(selected ))        
