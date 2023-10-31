#!python

#
# Perl Weekly Challenge 241
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-241/>
#

import sys

# task implementation
def main( argv ):
    diff = int(argv[ 0 ])
    nums = list( map( int, argv[ 1: ] ) )
    counter = 0

    for i in range( 0, len( nums ) ):
        for j in range( i + 1, len( nums ) ):
            for k in range( j + 1, len( nums ) ):
               if ( ( nums[ k ] - nums[ j ] ) == ( nums[ j ] - nums[ i ] ) and ( nums[ k ] - nums[ j ] ) == diff ):
                   counter += 1

    print( counter )
    return counter



# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


