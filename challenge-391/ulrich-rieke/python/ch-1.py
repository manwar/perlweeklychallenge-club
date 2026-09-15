#!/usr/bin/env python3

firstline = input( "Enter a sorted array of integers!\n" )
secondline = input( "Enter a second array of sorted integers!\n" )
firstarray = []
secondarray = []
if firstline != "":
   for w in firstline.split( ' ' ):
      firstarray.append( int(w) )
if secondline != "":
   for w in secondline.split( ' ' ):
      secondarray.append( int(w ) )
for n in secondarray:
   firstarray.append( n )
mySorted = sorted( firstarray )   
l = len( firstarray )
if l % 2 == 1:
   print( mySorted[l // 2] )
else:
   print ((mySorted[l // 2 - 1] + mySorted[l // 2 ]) / 2.0 )
