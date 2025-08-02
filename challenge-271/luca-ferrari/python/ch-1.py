#!python

#
# Perl Weekly Challenge 271
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-271>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    matrix = []
    row    = 0
    matrix.append( [] )
    for v in args:
        if v == '|':
            row += 1
            matrix.append( [] )
            continue

        matrix[ row ].append( int( v ) )

    ones = {}
    for r in range( 0, len( matrix ) ):
        counting = len( list( filter( lambda x: x == 1, matrix[ r ] ) ) )
        ones[ str( r ) ] = counting

    min_row = None
    for r in ones:
        if ones[ r ] > 0:
            if min_row is None or min_row > int( r ):
                min_row = int( r ) + 1

    return min_row

    



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
