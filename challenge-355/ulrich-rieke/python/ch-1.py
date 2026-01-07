#!/usr/bin/env python3

def chunksOfThree( numberstring ):
    funcresult = ""
    lettercount = 0
    for i in range( 0 , len( numberstring )):
        funcresult += numberstring[i:i + 1]
        lettercount += 1
        if lettercount % 3 == 0 and lettercount != len( numberstring ):
            funcresult += ','
    return funcresult

def separate( number ):
    numberstring = str( number )
    length = len(numberstring)
    result = ""
    if length <= 3:
       result = numberstring
    else:
       leading = length % 3
       if leading != 0:
           result = numberstring[0:leading]
           rest = numberstring[leading:length]
           result += ','
           chunks = chunksOfThree( rest )
           result += chunks
       else:
           result = chunksOfThree( numberstring)
    return result

print( chunksOfThree(str(528843211)))
startnumbers = [123 , 1234 , 1000000 , 1 , 12345]  
result = map( lambda n: separate( n ) , startnumbers )
print( list(result))    
