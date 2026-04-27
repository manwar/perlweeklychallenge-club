#!/usr/bin/env python3
import re
import string
def convert( word ):
   converted = ""
   for c in word:
      if c.islower( ):
         converted += c
      if c.isupper( ):
         converted += c.lower()
   return converted      

paragraph = input( "Enter a paragraph!\n" )
bannedline = input( "Enter some banned words separated by whitespace!\n" )
paralist = paragraph.split( ' ' ) ;
if len( paralist) == 1:
   forbidden = string.punctuation 
   changed = ""
   for c in paragraph:
      if c in forbidden:
         changed += ' '
      else:
         changed += c
   paragraph = changed       
paralist = paragraph.split( ' ')
banned = bannedline.split( ' ' )
frequencies = {}
converted = []
for w in paralist:
   converted.append( convert( w ) )
for w in converted:
   if w not in banned:
      if w not in frequencies.keys():
         frequencies[w] = 1
      else:   
         frequencies[w] += 1
most_freq = max( frequencies.values( ) )
solution = ""   
for k in frequencies.keys( ):
   if frequencies[k] == most_freq:
      solution = k
print( solution )   
