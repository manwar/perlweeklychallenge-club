#!/usr/bin/env python3

line = input( "Enter at least 3 integers separated by blanks!\n") ;
numbers = []
for w in line.split( ' ' ):
   numbers.append( int( w ) ) 
indices = []
for i in range(1, len(numbers) - 1):
   if numbers[i] > numbers[i - 1] and numbers[i] > numbers[i + 1]:
      indices.append( i )
print( indices )   
