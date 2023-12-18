#!python

#
# Perl Weekly Challenge 248
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-248/>
#

import sys

# task implementation
def main( argv ):
    string = argv[ 0 ]
    char   = argv[ 1 ]

    matching = []
    for i in range( 0, len( string ) ):
        c = string[ i ]
        if c == char:
            matching.append( i )

    distances = []
    for i in range( 0, len( string ) ):
        if string[ i ] == char:
            distances.append( 0 )
        else:
            distances.append( min( map( lambda x: abs( i - x ), matching ) ) )

    print( ', '.join( map( str, distances ) ) )


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


