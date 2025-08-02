#!python

#
# Perl Weekly Challenge 270
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-270>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    row_size = int( args[ 0 ] )
    matrix   = []

    # build the matrix
    current_row = 0
    matrix.append( [] )
    for x in args[ 1: ]:

        if len( matrix[ current_row ] ) >= row_size:
            current_row += 1
            matrix.append( [] )

        matrix[ current_row ].append( int( x ) )


    ones = []
    for r in range( 0, len( matrix ) ):
        for c in range( 0, len( matrix[ r ] ) ):
            if matrix[ r ][ c ] == 1:
                ones.append( [ r, c ] )

    for current in ones:
        found = list( filter( lambda x: x[ 0 ] == current[ 0 ] or x[ 1 ] == current[ 1 ], ones ) )
        if len( found ) == 1:
            print( current )


    return ""

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
