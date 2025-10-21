#!/usr/bin/env python3

def decompose( number ):
   digitarray = []
   while number != 0:
      digitarray.append( number % 10 )
      number //= 10
   result = []
   for i in reversed( digitarray ):
      result.append( i )
   return result   


startarray = []
line = input("Enter some integers separated by blanks!\n")
for w in line.split( ' ' ):
   startarray.append(int(w))
line = input( "Enter an integer!\n" )
x = int(line) 
rightOrder = reversed( startarray ) 
total = 0
pos = 0   
for num in rightOrder:
   total += num * 10 ** pos
   pos += 1
result = total + x
print( decompose( result ) )   
