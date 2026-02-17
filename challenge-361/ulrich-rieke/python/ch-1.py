#!/usr/bin/env python3 

def fibonacci( number ):
   if number == 0 or number == 1:
      return number
   if number > 1:
      return ( fibonacci( number - 2 ) + fibonacci( number - 1 ) )

number = int( input( "Enter a number <= 100!\n"))
fibonaccis = [fibonacci( n ) for n in range( 0, 13)]
rev = []
for item in fibonaccis[::-1]:
   rev.append( item )
result = []
while number != 0:
   pos = 0
   while rev[pos] > number:
      pos += 1
   result.append( rev[pos] )
   number -= result[-1] 
print( result )   
