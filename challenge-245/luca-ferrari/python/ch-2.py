#!python

#
# Perl Weekly Challenge 245
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-245/>
#

import sys
from itertools import permutations

# task implementation
def main( argv ):
    digits = list( map( int, argv ) )

    result = -1

    for p in permutations( digits ):
        value = int( "".join( map( str, p ) ) )

        if value % 3 != 0:
            continue

        if value > result:
            result = value

    print( result )



# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


