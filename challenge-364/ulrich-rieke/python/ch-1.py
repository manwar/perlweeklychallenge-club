#!/usr/bin/env python3

import re
def convert( word , conversions):
   m = re.search( r"\d{2}#" , word)
   while m:
      it = re.finditer( r"\d{2}#" , word )
      for w in it:
         st = w.group(0)
         word = word.replace( st , conversions[st] )
      m = re.search( r"\d{2}#" , word) 
   n = re.search( r"\d" , word )
   while n:
      itn = re.finditer( r"\d" , word )
      for w in itn:
         s = w.group( 0 )
         word = word.replace( s , conversions[s]) 
      n = re.search( r"\d" , word )
   return word

conversions = {}
lowerletters = "abcdefghi"
upperletters = "jklmnopqrstuvwxyz"
for i in range( 0 , len( lowerletters )):
   conversions[str( i + 1)] = lowerletters[i]
for i in range( 0 , len( upperletters )):
   conversions[str( i + 10 ) + "#"] = upperletters[i]
print( convert( "10#11#12" , conversions) ) 
print( convert( "1326#" , conversions ) ) 
print( convert( "25#24#123" , conversions ))
print( convert( "20#5" , conversions))   
print( convert( "1910#26#" , conversions ) )
