#!/usr/bin/env python3

def sanitize( word ):
   sanitized = ""
   for c in word:
      if c.isalpha( ):
         sanitized += c
   return sanitized

sentence = input( "Enter a sentence!\n" ) 
sentence = sentence.lstrip( ) ;
sentence = sentence.rstrip( )
saniWords = []
for w in sentence.split( ' ' ):
   sani = sanitize( w )
   if sani:
      saniWords.append( sani )
output = "#"
sanilen = len( saniWords )
firstWord = saniWords[0]       
output += firstWord.lower( ) 
if sanilen > 1:
      for i in range(1,sanilen):
         current = saniWords[i]
         firstLetter = current[0:1] 
         output += firstLetter.upper( ) 
         remainder = current[1:] 
         output += remainder.lower( )
if len( output ) > 100:
   output = output[0:100]   
print(output )      
