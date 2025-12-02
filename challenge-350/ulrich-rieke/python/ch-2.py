#!/usr/bin/env python3

def arePaired(firstNum , secondNum):
    firstStr = str( firstNum )
    secondStr = str( secondNum )
    if len( firstStr ) == len( secondStr ): 
        firstset = {c for c in firstStr}
        secondset = {c for c in secondStr}
        return firstset == secondset and len( secondset ) == len( firstStr )
    else:
        return False 

def findPairs( fromnum , to , count):
    pairs = []
    for i in range( fromnum , to + 1):
        found = 0
        for mult in range(2 , 10 ):
            if arePaired( i , mult * i):
                found += 1 
                if found == count:
                   pairs.append( i )
                   break
    return len( pairs )

print( findPairs( 1 , 1000 , 1 ) )                
print( findPairs( 1500 , 2500 , 1 ))    
print( findPairs( 1000000 , 1500000 , 5 ))
print( findPairs( 13427000 , 14100000 , 2 ))
print( findPairs( 1030 , 1130 , 1 ))    
