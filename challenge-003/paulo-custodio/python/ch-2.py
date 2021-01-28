#!/usr/bin/env python

# Challenge 003
#
# Challenge #2
# Create a script that generates Pascal Triangle. Accept number of rows from
# the command line. The Pascal Triangle should have at least 3 rows. For more
# information about Pascal Triangle, check this wikipedia page.

import sys

def draw_pascal(rows):
    data = [1]
    for row in range(1,rows+1):
        # print current row
        print(" "*(rows-row) + " ".join([str(x) for x in data]))

        # compute next row
        nxt = [1]
        for col in range(0, len(data)-1):
            nxt.append(data[col] + data[col+1])
        nxt.append(1)
        data = nxt

# main
draw_pascal(int(sys.argv[1]))
