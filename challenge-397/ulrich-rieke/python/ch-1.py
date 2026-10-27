#!/usr/bin/env python3 
from math import ceil

numberline = input( "Enter some integers separated by blanks!\n" )
numbers = [int( s ) for s in numberline.split( ' ' )]
mySum = 0
for i in numbers:
   mySum += i
average = mySum / len( numbers )
ceiling = ceil( average )
current = 0
if ceiling == average:
   current = average + 1
else:
   current = ceiling
while current <= 0:
   current += 1
while current in numbers:
   current += 1
print( int(current) )   
