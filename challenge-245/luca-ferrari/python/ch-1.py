#!python

#
# Perl Weekly Challenge 245
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-245/>
#

import sys

# task implementation
def main( argv ):
    langs = argv[ 0 ].split( "|" )
    popularity = list( map( int, argv[1].split( "|" ) ) )

    sorting = {}
    for i in range( 0, len( popularity ) ):
        sorting[ langs[ i ] ] = popularity[ i ]


    for v in sorted( sorting.items(), key=lambda x: x[1], reverse=True ):
        print( v[0] )



# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


