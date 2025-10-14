#!/usr/bin/env python3

line = input( "Enter some integers separated by blanks!\n" ) ;
differences = []
for w in line.split( ' ' ):
   differences.append(abs(int(w)))
print( min( differences ))   
