#!/usr/bin/env python3

line = input( "Enter some integers separated by blanks!\n" )
numbers = [int( n ) for n in line.split( ' ' )]
differences = []
for i in range( 0 , len( numbers ) - 1 ):
   differences.append( numbers[i] - numbers[i + 1] )
if 0 in differences:
   print( "False" )
else:   
   l = len( differences )
   firstPart = []
   pos = 0 
   while pos < l and differences[pos] < 0:
      firstPart.append( differences[pos] )
      pos += 1
   secondPart = []
   while pos < l and differences[pos] > 0:
      secondPart.append( differences[pos] )
      pos += 1
   thirdPart = []
   while pos < l and differences[pos] < 0:
      thirdPart.append( differences[pos] )
      pos += 1
   print( len( firstPart ) > 0 and len( secondPart ) > 0 and \
         len( thirdPart ) > 0 and len( firstPart ) + len( secondPart )
          + len( thirdPart ) == l )
