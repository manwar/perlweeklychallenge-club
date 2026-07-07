#!/usr/bin/env python3

matrixlines = []
line = input( "Enter a n x n matrix with numbers from 1 to n!\n" )
while len( line ) > 0:
   matrixlines.append( line ) ;
   line = input( "Another line or no line!\n" )
l = len( matrixlines )   
matrix = []
for row in matrixlines:
   rowline = [int( w ) for w in row.split( ' ')]
   matrix.append( rowline )
comparison = []
for i in range( 1 , l + 1 ):
   comparison.append( i )
row_ok = True
for row in matrix:
   myRow = sorted( row ) 
   if myRow != comparison:
      row_ok = False
col_ok = True
for col in range(0 , l):
   current_col = []
   for row in range( 0 , l ):
      current_col.append( matrix[row][col] )
   my_current = sorted( current_col )
   if my_current != comparison:
      col_ok = False 
print( row_ok and col_ok )      
