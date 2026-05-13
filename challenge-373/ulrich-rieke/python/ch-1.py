#!/usr/bin/env python3

firstline = input( "Enter some words separated by blanks!\n" )
secondline = input ( "Enter some more words separated by blanks!\n" )
firstTerm = ""
secondTerm = ""
for w in firstline.split( ' ' ):
   firstTerm += w
for w in secondline.split( ' '):
   secondTerm += w
print( firstTerm == secondTerm )   
