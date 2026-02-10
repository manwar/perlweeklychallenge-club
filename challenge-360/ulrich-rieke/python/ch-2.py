#!/usr/bin/env python3
import re 

line = input( "Enter a sentence!\n" )
pattern = r'\s+' 
line = re.sub( pattern, ' ' , line ) 
allWords = line.split( ' ' ) 
allWords = sorted( allWords , key=str.lower )
print( ' '.join(allWords ))   
