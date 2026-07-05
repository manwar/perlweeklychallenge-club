#!/usr/bin/env python3

word = input( "Enter a string consisting of English letters only!\n" )
vowels = "aeiouAEIOU"
vowelcount = {}
consocount = {}
for c in word:
   if c in vowels:
      if c not in vowelcount:
         vowelcount[c] = word.count( c ) 
   else:
      if c not in consocount:
         consocount[c] = word.count( c )
vowelmax = 0
consomax = 0
if len( vowelcount ) > 0:
   vowelmax += max( vowelcount.values( ) )
if len( consocount ) > 0:
   consomax += max( consocount.values( ) )
print( vowelmax + consomax )   
