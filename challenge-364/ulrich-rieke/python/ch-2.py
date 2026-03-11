#!/usr/bin/env python3
import re

def solution( word ):
   word = re.sub( r"\(\)", "o" , word )
   word = re.sub( r"\(al\)" , "al" , word)
   return word

print( solution( "G()(al)" ))
print( solution( "G()()()()(al)" ))
print( solution ( "(al)G(al)()()" ))
print( solution( "()G()G" )) 
print( solution( "(al)(al)G()()" ))
