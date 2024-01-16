#!python

#
# Perl Weekly Challenge 248
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-248/>
#

import sys

# task implementation
def main( argv ):
    matrix = argv
    output = []

    for r in range( 0, len( matrix ) - 1 ):

        output.append( [] )

        for c in range( 0, len( matrix[ r ] ) - 1 ):
            output[ r ].append( matrix[ r ][ c ] + matrix[ r ][ c + 1 ] + matrix[ r + 1 ][ c ] + matrix[ r + 1 ][ c + 1 ] )

    print( "\n".join( map( str, output ) ) )


# invoke the main without the command itself
if __name__ == '__main__':
    matrix = [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ]

    matrix = [
              [1,  2,  3,  4],
              [5,  6,  7,  8],
              [9, 10, 11, 12]
            ]

    main( matrix )
