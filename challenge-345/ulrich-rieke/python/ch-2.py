#!/usr/bin/env python3

line = input( "Enter some integers and -1 separated by blanks!\n" )
numbers = []
for w in line.split( ' ' ):
   numbers.append(int(w))
seen = []
ans = []
x = 0   
length = len( numbers) 
pos = 0
while pos < length:
   n = numbers[pos]
   if n > 0:
      x = 0
      seen.insert( 0 , n )
   else:
      if x < len(seen):
      	  ans.append( seen[x] )
      else:
      	  ans.append( -1 )
      if pos < length - 1 and numbers[pos + 1] == -1:
      	  x += 1
   pos += 1
print( ans )   
