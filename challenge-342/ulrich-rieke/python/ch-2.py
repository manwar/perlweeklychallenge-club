#!/usr/bin/env python3 

line = input("Enter a string consisting of 0 and 1 only!\n") ;
ln = len( line ) ;
subsums = [] ;
for pos in range(1,ln):
   firstpart = line[0:pos]
   secondpart = line[pos:ln]
   zeroes = firstpart.count( '0' ) 
   ones = secondpart.count('1') ;
   subsums.append( zeroes + ones ) 
subsums.sort( ) 
print(subsums[-1])   
