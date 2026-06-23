#!/usr/bin/env python3

def isArmstrong( base , number):
   comparison = number 
   basedigits = []
   while number != 0:
      basedigits.append( number % base )
      number = number // base
   truthvalues = [n < 10 for n in basedigits]
   l = len( basedigits )
   converted = [n ** l for n in basedigits]
   if not all( [truthvalues]):
      return False
   else:
      mySum = 0 
      for n in converted:
         mySum += n
      return mySum == comparison

line = input( "Enter , separated by blanks , a base and a limit!\n" )
parts = line.split( ' ' )
base = int( parts[0] )
limit = int( parts[1] )
solution = []
for n in range( 0 , base ):
   solution.append( n )
for n in range( base , limit):
   if isArmstrong( base , n):
      solution.append( n )
print( solution )      
