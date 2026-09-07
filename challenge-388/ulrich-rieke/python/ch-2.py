#!/usr/bin/env python3
from itertools import permutations

numberline = input( "Enter a positive integer!\n" )
number = int( numberline ) 
if number == 1:
   print( 0 )
if number == 2:
   print( 1 )
if number > 2:   
   original = [n for n in range(1 , number + 1 )]
   myCopy = []
   for n in original:
      myCopy.append(n)
   allCombis = []   
   z = []
   for item in permutations( myCopy ):   
      zipped = zip( original , item ) 
      z = list( zipped )
      val = all( [p[0] != p[1] for p in z ] )
      if val and z not in allCombis:
         allCombis.append( z )
   print( len( allCombis ) )      
