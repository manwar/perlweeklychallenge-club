#!/usr/bin/env python3
#is second date later than first date
def isLater( firstTime , secondTime):
   [firstHours , firstMinutes] = firstTime.split( ':' )
   [secondHours , secondMinutes] = secondTime.split( ':' )
   if firstHours != secondHours:
      return secondHours > firstHours
   else:
      return secondMinutes > firstMinutes

firstEvent = input( "Enter start and end times of a first event!\n" )
secondEvent = input( "Enter start and end times of a second event!\n")
[firstStart , firstEnd] = firstEvent.split( ' ' )
[secondStart , secondEnd] = secondEvent.split( ' ' )
result = True
if firstStart == secondStart:
   result = True
else:
   if isLater( firstEnd , secondStart ) or firstEnd == secondStart:
      result = False
print( result )      
