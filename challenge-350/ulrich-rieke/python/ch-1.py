#!/usr/bin/env python3

word = input( "Enter a word!\n") ;
count = 0
length = len( word )
for i in range( 0 , length - 2 ):
    part = {c for c in word[i:i+3]}
    if len(part) == 3:
      count += 1
print( count )      
