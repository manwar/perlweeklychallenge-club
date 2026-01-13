#!/usr/bin/env python3

def find_list( number , kolalist):
    i = 3
    while i < number:
        if i % 2 == 1:
            for n in range(0 , kolalist[i - 1]):
                kolalist.append( 1 )
        else:
            for n in range( 0 , kolalist[i - 1] ):
                kolalist.append( 2 )
        i += 1
    return kolalist

numberline = input( "Enter a number greater than 3!\n" ) 
number = int( numberline ) 
kola = [1 , 2 , 2]
kola = find_list( number , kola ) 
print( kola[0:number].count( 1 ) )   
