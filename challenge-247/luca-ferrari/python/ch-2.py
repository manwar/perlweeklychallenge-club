#!python

#
# Perl Weekly Challenge 247
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-247/>
#

import sys

# task implementation
def main( argv ):
    string = argv[ 0 ]
    score = {}
    for i in range( 0, len( string ) - 1 ):
        needle = string[ i ] + string[ i + 1 ]
        counting = string.count( needle )
        if not counting in score:
            score[ counting ] = []

        if not needle in score[ counting ]:
            score[ counting ].append( needle )

    # get the highest key and extract the min value
    print( min( score[ max( score.keys() ) ] ) )

# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


