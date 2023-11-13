#!python

#
# Perl Weekly Challenge 243
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-243/>
#

import sys

# task implementation
def main( argv ):
    nums = list( map( int, argv ) )
    counter = 0

    for i in range( 0, len( nums ) ):
        for j in range( i + 1, len( nums ) ):
            if nums[ i ] > 2 * nums[ j ]:
                counter = counter + 1;

    print( counter )


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


