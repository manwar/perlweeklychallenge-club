#!/usr/bin/env python3
source = input("Enter a source time!\n")
target = input( "Enter a target time!\n")
(sourcehours , sourceminutes) = (int( source[0:2] ) , int(source[3:]))
(targethours , targetminutes ) = (int( target[0:2] ) , int( target[3:] )) 
if targethours < sourcehours:
   targethours += 24
ops = [1 , 5 , 15 , 60]
diffminutes = targethours * 60 + targetminutes - ( sourcehours * 60 + sourceminutes )
operations = []
while diffminutes != 0:
   selected = [x for x in ops if x <= diffminutes]
   divisor = max ( selected )
   operations.append( diffminutes // divisor )
   diffminutes -= divisor * operations[-1]
print( sum( operations ) )   
