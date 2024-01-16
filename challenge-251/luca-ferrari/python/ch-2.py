#!python

#
# Perl Weekly Challenge 251
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-251/>
#

import sys

# task implementation
def main( argv ):
    matrix = []
    row = 0
    matrix.append( [] )

    for x in argv[ 0 ]:
        if x == ' ':
            continue

        # change row
        if x == '|':
            row += 1
            matrix.append( [] )
            continue

        matrix[ row ].append( int( x ) )

    # make indexes of max columns
    max_cols = []
    for col in range( 0, len( matrix ) ):
        current_max = None
        for row in range( 0, len( matrix[ 0 ] ) ):
            if not current_max or current_max < matrix[ row ][ col ] :
                current_max = matrix[ row ][ col ]

        max_cols.append( current_max )

    for row in range( 0, len( matrix ) ):
        current_min = None
        current_min_col = None

        for col in range( 0, len( matrix[ row ] ) ):
            if not current_min or current_min > matrix[ row ][ col ]:
                current_min = matrix[ row ][ col ]
                current_min_col = col

        if current_min == max_cols[ current_min_col ]:
            return current_min

    return -1




# invoke the main without the command itself
if __name__ == '__main__':
    print( main( sys.argv[ 1: ] ) )
