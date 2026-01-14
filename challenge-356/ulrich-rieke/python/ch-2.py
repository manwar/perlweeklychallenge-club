#!/usr/bin/env python3

def find_ties( result , ties):
    resultpairs = []
    for i in range( 0 , len( result ) ):
        resultpairs.append( (result[i] , ties[i]) )
    seedings = []
    for pair in resultpairs:
        if pair[0] == "H":
            seedings.append( pair[1][0] )
        else:
            seedings.append( pair[1][1] )
    seedings.sort( )
    return seedings

def find_result( resultstring):
    firstpart = resultstring[0:3]
    first_round_seedings = find_ties( firstpart , [(2 , 7) , (3 , 6 ) , (4 , 5)] )
    second_round_seedings = find_ties( resultstring[3:5] , [(1 , first_round_seedings[2]) ,  
                (first_round_seedings[0] , first_round_seedings[1] )] )  
    second_round_seedings.sort( ) 
    if resultstring[5] == "H":
        result = " ".join( ["Team" , str( second_round_seedings[0]) , "defeated Team" , 
                    str( second_round_seedings[1] )]) 
    else:
        result = " ".join(["Team", str( second_round_seedings[1]), "defeated Team" ,
        str( second_round_seedings[0] )])
    return result

print( find_result( "HAHAHH" ))
print( find_result( "HHHHHH" )) 
print( find_result( "HHHAHA" ))
print( find_result( "HAHAAH" ))
print( find_result( "HAAHAA"))    
