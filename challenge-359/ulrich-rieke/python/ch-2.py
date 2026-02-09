#!/usr/bin/env python3
import re

def eliminate_doublets(word):
     pattern = r"(.)\1"
     m = re.search(pattern, word)
     while m:
          word = re.sub(pattern, "", word)
          m = re.search( pattern , word )
     return word

aWord = input( " Enter a word!\n")
result = eliminate_doublets(aWord)
if len( result ) == 0:
     print( "\" \"")
else:
     print( result )
