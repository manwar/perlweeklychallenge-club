#!python

#
# Perl Weekly Challenge 244
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-244/>
#

import sys
from itertools import combinations;

# task implementation
def main( argv ):
    nums = list( map( int, argv ) )
    power = 0

    for size in range( 1, len( nums ) + 1 ):
        for current in combinations( nums, size ):
            power = power + ( max( current ) ** 2 ) * min( current )

    print( power )



# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


