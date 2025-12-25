#!/usr/bin/env python3

lengths = []
firstline = input( "Enter a sentence , <return> to end!\n") 
while len( firstline ) > 0:
   wordarray = []
   for w in firstline.split( ' ' ):
       wordarray.append( w )
   lengths.append( len( wordarray ) ) 
   firstline = input( "Enter a sentence , <return> to end!\n")    
print( max( lengths ) )       
