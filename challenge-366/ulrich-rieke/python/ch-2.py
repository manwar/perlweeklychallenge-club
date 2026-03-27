#!/usr/bin/env python3
def findPossibilities( timeterm ):
   possibilities = 1
   if timeterm[0:2] == "??":
      possibilities *= 24
   else:
      if timeterm[0] == '?':
         if int(timeterm[1]) < 4:
            possibilities *= 3
         else:
            possibilities *= 2
      if timeterm[1] == '?':
         if int( timeterm[0] ) < 2:
            possibilities *= 10
         else:
            possibilities *= 4
   if timeterm[-2] == '?':
      possibilities *= 6
   if timeterm[-1] == '?':
      possibilities *= 10
   return possibilities

print( findPossibilities("?2:34") )
print( findPossibilities("?4:?0") )
print( findPossibilities("??:??") )
print( findPossibilities("?3:45") )
print( findPossibilities("2?:15") )  
