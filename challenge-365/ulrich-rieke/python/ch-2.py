#!/usr/bin/env python3

#beware of monster regexes , they are certain to become a part of the problem!!!
import re
def hyphens( word ):
   condition = False 
   if '-' in word:
      pos = word.index( '-')
      condition = word.count( '-' ) == 1 and pos != len( word ) - 1 \
                  and  word[pos -1].islower( ) and word[pos + 1].islower( )
   else:
      condition = True
   return condition

def puncts( word ):
   punctuations = "!.,"
   relevantLetters = [c for c in word if c in punctuations]
   if len( relevantLetters ) == 1:
      return re.search( r"[!,.]$" , word )
   if len( relevantLetters ) > 1:
      return False
   return True

def correctLetters( word ):
   values = []
   for letter in word:
      values.append( not letter.isdigit( ) ) 
   return( all( values ))

def isValid( word ):
   values = [puncts( word ) , correctLetters( word ) , hyphens( word )]
   return all( values )

sentence = input( "Enter a sentence!\n" ) 
selected =  filter( lambda w: isValid( w ),  sentence.split( ' ' ))
print( len( list( selected )))
