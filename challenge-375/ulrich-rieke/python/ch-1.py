#!/usr/bin/env python3

firstline = input( "Enter some strings separated by blanks!\n" )
secondline = input( "Enter some more strings separated by blanks!\n" ) ;
firstwords = firstline.split( ' ' )
secondwords = secondline.split( ' ' ) 
selected = [w for w in firstwords if firstwords.count( w ) == 1 and \
           secondwords.count( w ) == 1]
print( len( selected))           
