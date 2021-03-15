#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as python ch-1.py < input-file
#

from math import floor, sqrt
import sys

RIGHT = 0
UP    = 1
LEFT  = 2
DOWN  = 3

#
# Fetch data
#
elements = input () . split ()

#
# Find the optimal width and height
#
count = len (elements)
height = floor (sqrt (count))
while count % height:
    height = height - 1

width = floor (count / height)


#
# Initialize the matrix
#
min_x = 0
max_x = height - 1
min_y = 0
max_y = width - 1

matrix = [[0] * width for x in range (height)]
    

#
# Fill the matrix, starting at the bottom left
#
x         = max_x
y         = min_y
direction = RIGHT
for element in elements:
    matrix [x] [y] = element
    turn = False
    if  direction == RIGHT:
        if  y >= max_y:
            turn = True; x = x - 1; max_x = max_x - 1
        else:
            y = y + 1

    if  direction == UP:
        if  x <= min_x:
            turn = True; y = y - 1; max_y = max_y - 1
        else:
            x = x - 1

    if  direction == LEFT:
        if  y <= min_y:
            turn = True; x = x + 1; min_x = min_x + 1
        else:
            y = y - 1

    if  direction == DOWN:
        if  x >= max_x:
            turn = True; y = y + 1; min_y = min_y + 1
        else:
            x = x + 1

    if  turn:
        direction = direction + 1
        direction = direction % 4


#
# Find the widths of each column
#
widths = [0] * width

for y in range (width):
    max = 0
    for x in range (height):
        if  max < len (matrix [x] [y]):
            max = len (matrix [x] [y])
    widths [y] = max


#
# Print the matrix
#
for x in range (height):
    for y in range (width):
        if  y > 0:
            sys . stdout . write (" ")
        #
        # Format the entry. Format will look something like '{:>Ws}',
        # where W is the width of the column.
        #
        sys . stdout . write (("{:>" + str (widths [y]) + "s}") .
                                format (matrix [x] [y]))
    sys . stdout . write ("\n")
