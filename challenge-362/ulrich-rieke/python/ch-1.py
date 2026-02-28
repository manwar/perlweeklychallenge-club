#!/usr/bin/env python3

word = input( "Enter a word!\n" )
result = ""
howmany = 1
for w in word:
   for i in range( howmany ):
      result += w
   howmany += 1
print( result )      
