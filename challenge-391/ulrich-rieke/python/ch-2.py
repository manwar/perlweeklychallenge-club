#!/usr/bin/env python3

line = input( "Enter an even number of positive integers!\n" )
numbers = [int( w ) for w in line.split( ' ' )]
pairs = []
pos = 0 
while pos < len( numbers ) - 1:
   p = numbers[pos] , numbers[pos + 1]
   pairs.append( p )
   pos += 2
mySorted = sorted( pairs , key=tuple[0] )
selected = []
selected.append( mySorted[0] ) ;
for i in range( 1 , len(mySorted )):
   if mySorted[i][0] > selected[-1][0] and mySorted[i][1] \
      > selected[-1][1]:
      selected.append( mySorted[i] )
print( len( selected ))   
