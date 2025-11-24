#!/usr/bin/env python3

def up(pair):
    result = (pair[0] , pair[1] + 1)
    return result

def down(pair):
    result = (pair[0] , pair[1] - 1)
    return result

def left(pair):
    result = (pair[0] - 1 , pair[1])
    return result

def right(pair):
    result = (pair[0] + 1 , pair[1] )
    return result

letters = input( "Enter some letters U , R , L or D to denote motions!\n")
movements = { 'D' : down , 'U' : up , 'R' : right , 'L' : left }
current = (0 , 0 )
for c in letters:
    current = movements[c]( current )
if current[0] == 0 and current[1] == 0:
    print("true")
else:
    print( "false" )
