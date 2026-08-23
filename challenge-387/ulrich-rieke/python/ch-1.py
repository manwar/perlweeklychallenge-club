#!/usr/bin/env python3 

binary = input( "Enter a binary string!\n" )
steps = 0
while binary.find( '01' ) != -1:
   binary = binary.replace('01' , '10')
   steps += 1 
print( steps )   
