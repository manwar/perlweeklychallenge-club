#!/usr/bin/env python3

firstline = input( "Enter some strings!\n" )
frequencies = {}
for w in firstline.split( ' '):
   if w in frequencies:
      frequencies[w] += 1
   else:
      frequencies[w] = 1
secondline = input( "Enter some more strings!\n" ) 
for w in secondline.split( ' '):
   if w in frequencies:
      frequencies[w] += 1
   else:
      frequencies[w] = 1
selected = []
for w in frequencies.keys( ):
   if frequencies[w] == 1:
      selected.append( w )
print( selected )   
