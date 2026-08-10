#!/usr/bin/env python3

def can_be_converted( firstLine , secondLine , similarities ):
   if len( firstLine ) != len( secondLine ):
      return False 
   else:
      l = len( firstLine )
      selected = []
      for i in range( l ):
         if firstLine[i] != secondLine[i]:
            selected.append( i )
      if len( selected ) == 0:
         return True
      else:
         truthvalues = []
         for i in range( len( selected )):
            truthvalues.append( firstLine[i] in similarities.keys( ) and \
                  secondLine[i] in similarities[firstLine[i]] )
            return all(truthvalues)

firstline = input( "Enter a list of words separated by blanks!\n" )
secondline = input( "Enter a second line of words separated by blanks!\n" )
similarities = {}
print( "Enter a list of lists of words, enter <newline> to end entry!" )
line = input( "Next line, or end!\n" ) ;
while len(line) > 0:
   similar = []
   allWords = line.split( ' ' )
   for i in range( 1 , len( allWords )):
      similar.append( allWords[i] )
   similarities[allWords[0]] = similar
   line = input( "Next line , or end!\n" )   
firstWords = firstline.split( ' ' )
secondWords = secondline.split( ' ' )
print( (can_be_converted( firstWords , secondWords , similarities )) or \
      (can_be_converted( secondWords , firstWords , similarities )))
        
