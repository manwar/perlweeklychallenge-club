#!/usr/bin/env python3

def rotateLeft( numbers ):
    rotated = []
    rotated.append( numbers[-1] )
    for i in range( 0 , len( numbers ) - 1):
        rotated.append( numbers[i] )
    return rotated

allNumbers = []
line = input( "Enter m x n integers , enter <return> to end!\n" )
columns = 0
while len( line ) > 0:
   singlewords = []
   for word in line.split( ' ' ):
       singlewords.append( word )
   columns = len( singlewords )    
   for w in singlewords:
       allNumbers.append( int( w ) )
   line = input( "Enter integers !\n" )
shi = input( "How many shifts do you want to perform?\n" )
shifts = int( shi )       
rows = len( allNumbers ) // columns
shifted = allNumbers
for i in range(0 , shifts ):
    shifted = rotateLeft( shifted )
aRow = []    
print("(")
for r in range(0, rows):
    for i in range(r * columns , r * columns + columns ):
        aRow.append( shifted[i] )
    print( "  " + str(aRow)  )
    aRow.clear( )
print(")")        
