#!/usr/bin/env python3
import re 

sentence = input( "Enter a text with words surrounded by spaces!\n")
totalspaces = sentence.count( ' ' )
start = re.compile( r"^\s+" )
end = re.compile( r"\s+$" )
newtext = start.sub( "" , sentence ) 
newtext = end.sub( "" , newtext )
match = re.search( r"\s+" , newtext )
output = ""
if match:
   midpattern = re.compile ( r"\s+" )
   newtext = midpattern.sub( " " , newtext )
   allWords = newtext.split( ' ' )
   l        = len( allWords )
   gapspace = totalspaces // ( l - 1 )
   for i in range( 0 , l - 1):
      output += allWords[i]
      for d in range(0 , gapspace ):
         output += ' '
   output += allWords[-1]
   for i in range( 0 , totalspaces - gapspace * ( l - 1)):
      output += ' '
else:
   output += newtext
   for i in range(0 , totalspaces):
      output += ' '
print( output )      
