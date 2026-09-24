#!/usr/bin/env python3

def isPalindrome( word ):
   reverse = word[-1::-1]
   return reverse == word

string = input( "Enter a string!\n" )
if isPalindrome( string ):
   print( string )
else:
   maxi = 1
   for b in range( 2, len( string )):
      current = string[0:b]
      if isPalindrome( current ):
         if b - 1 > maxi:
            maxi = b - 1
   remainder = ""      
   if maxi == 1: 
      remainder = string[1:]
   else:
      remainder = string[maxi + 1:]
   remreversed = remainder[-1::-1]
   print( remreversed + string )      
