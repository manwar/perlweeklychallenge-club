#!/usr/bin/env python3

line = input("Enter some 0 and 1 , <enter> to end!\n")
matrix = []
while ( len( line ) > 0 ):
   row = []
   for w in line.split( ' ' ):
      row.append( int( w ) )
   matrix.append( row )
   line = input( "\n")
selected = len( [r for r in matrix if all(n == 0 for n in r)] )
result = 0
if selected != 1:
   result = -1
else:
   pos = 0
   while not (all( n == 0 for n in matrix[pos])):
      pos += 1
   for r in range( 0 , len(matrix) ):
      if r != pos and matrix[r][pos] != 1:
         result = -1
         break
      result = pos
print( result )      
