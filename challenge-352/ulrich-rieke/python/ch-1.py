#!/usr/bin/env python3

line = input( "Enter some words separated by whitespace!\n" ) ;
words = []
for w in line.split( ' ' ):
    words.append( w )
result = []
for w in words:
    found = any( w in ele and ele != w for ele in words )
    if found:
        if result.count( w ) == 0:
            result.append(w)
print( result )            
