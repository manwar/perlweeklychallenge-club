#!/usr/bin/env python3

numberline = input( "Enter some integers separated by whitespace!\n" )
numbers = [int( w ) for w in numberline.split( ' ' )]
result = "false"
if len(numbers) < 3:
   result = "false"
else:   
   maxint = max(numbers)
   maxpos = numbers.index( maxint )
   if maxpos == 0 or maxpos == len( numbers ) - 1:
       result = "false"
   else:
       rising = []
       for i in range(0 , maxpos - 1):
           rising.append( numbers[i] - numbers[i + 1])
       falling = []
       for i in range( maxpos , len( numbers ) - 1 ):
           falling.append( numbers[i] - numbers[i + 1] )
       firstlist = [num < 0 for num in rising]
       secondlist = [num > 0 for num in falling]
       if all( firstlist ) and all( secondlist ):
           result = "true"
print( result )           

