#!/usr/bin/env python3

def parseNumber( number ):
   pos = number.index( '+' )
   realpart = number[0:pos]
   imaginarypart = number[pos + 1:]
   real = int( realpart )
   image = 0
   if imaginarypart[0] == '(':
      image = int( imaginarypart[1:-2] )
   else:
      image = int( imaginarypart[0:-1] )
   return ( real , image )

numberline = input( "Enter two complex numbers as strings!\n" )
numbers = numberline.split( ' ' )
p1 = parseNumber( numbers[0] )
p2 = parseNumber( numbers[1] )    
c1 = complex(p1[0] , p1[1])
c2 = complex(p2[0] , p2[1] )
result = c1 * c2
output = str( int(result.real) ) + "+"
if result.imag >= 0:
   output += str( int(result.imag)) + "i"
else:
   output += "(" + str( int(result.imag) ) + ")i"
print( output )   
