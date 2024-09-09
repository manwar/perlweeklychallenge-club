#!/usr/bin/env python3

# Challenge 053
#
# TASK #1
# Rotate Matrix
# Write a script to rotate the followin matrix by given 90/180/270 degrees
# clockwise.
#
# [ 1, 2, 3 ]
# [ 4, 5, 6 ]
# [ 7, 8, 9 ]
# For example, if you rotate by 90 degrees then expected result should be like
# below
#
# [ 7, 4, 1 ]
# [ 8, 5, 2 ]
# [ 9, 6, 3 ]

m = [[ 1, 2, 3 ],
     [ 4, 5, 6 ],
     [ 7, 8, 9 ]];

def rotate90(m):
    return [[ m[2][0], m[1][0], m[0][0] ],
            [ m[2][1], m[1][1], m[0][1] ],
            [ m[2][2], m[1][2], m[0][2] ]]

def rotate180(m):
    return rotate90(rotate90(m))

def rotate270(m):
    return rotate90(rotate90(rotate90(m)))

def display(m):
    for row in m:
        print("[ "+", ".join([str(x) for x in row])+" ]")
    print("")

display(rotate90(m))
display(rotate180(m))
display(rotate270(m))
