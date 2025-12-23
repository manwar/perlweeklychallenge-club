#!/usr/bin/env python3

startline = input( "Enter some 0 or 1 separated by blanks!\n") 
result = []
singlewords = []
for w in startline.split( ' ' ):
    singlewords.append(w)
pos = 0
while singlewords[pos] == "0":
   result.append( True )
   pos += 1
length = len( singlewords )
numberstring = ""
for n in range( pos , length ):
    numberstring += singlewords[n]
    number = int( numberstring , 2 )
    result.append( number % 5 == 0 )
print( result )    
