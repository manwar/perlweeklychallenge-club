#!/usr/bin/env python3 ;

def to_string( array ):
   result = "("
   if len( array ) == 0:
      result += ( str(array[0]) + ")" ) ;
   else:
      for i in range(0, len(array) - 1):
         result += (str(array[i]) + ',')
      result += (str(array[-1]) + ")")   
   return result

numberline = input( "Enter some integers separated by blanks!\n") 
numbers = [int( w ) for w in numberline.split( ' ' )]
numline = input( "Enter a positive number!\n" )
num = int( numline )
l = len( numbers )
total = l // num 
remainder = l % num
if total == 0:
   print( -1 )
else:  
   output = "(" 
   if remainder != 0:
      pos = 0
      while pos != remainder * ( total + 1):
         subarray = []
         for i in range( 0 , total + 1):
            subarray.append( numbers[pos + i] )
         output += to_string( subarray )
         pos += total + 1
      pos = remainder * ( total + 1 )
      while pos != l:
         subarray = []
         for i in range( 0 , total ):
            subarray.append( numbers[pos + i] )
         output += to_string( subarray )
         pos += total 
   else:
      pos = 0
      while pos != l:
         subarray = []
         for i in range( 0 , total ):
            subarray.append( numbers[pos + i ] )
         output += to_string( subarray )
         pos += total
   output += ")"
   print( output )         
