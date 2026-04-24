#!/usr/bin/env python3
def areAnagrams(firstWord , secondWord):
   firstSorted = sorted( firstWord )
   secondSorted = sorted( secondWord )
   return firstSorted == secondSorted

def areScrambled( firstWord , secondWord ):
   wordlen = len( firstWord ) 
   for i in range(1 , wordlen - 1):
      if ( areAnagrams( firstWord[0:i] , secondWord[0:i] ) and \
            areAnagrams( firstWord[i:] , secondWord[i:] ) ) or \
           (areAnagrams( firstWord[i:] , secondWord[0:i]) and \
            areAnagrams( firstWord[0:i] , secondWord[i:] )):
          return True
   return False

line = input( "Enter two strings with equal length!\n" )  
[wordA , wordB] = line.split( ' ' )
print( areScrambled( wordA , wordB ) )

