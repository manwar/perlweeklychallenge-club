#!python

#
# Perl Weekly Challenge 253
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
#

import sys
import collections

# task implementation
# the return value will be printed
def task_2( args ):
    ones = {}
    for row_index in range( 0, len( args ) ):
        sum = 0
        for x in args[ row_index ]:
            sum += x

        if not sum in ones:
            ones[ str( sum ) ] = []

        ones[ str( sum ) ].append( row_index )

    keys = list( ones.keys() )
    keys.sort()
    result = ""
    for k in keys:
        ones[ k ].sort()
        for v in ones[ k ]:
            result += str( v ) + ','


    return result

            

# invoke the main without the command itself
if __name__ == '__main__':
    matrix = [
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 0],
        [1, 0, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 1]
        ]
    print( task_2( matrix ) )
