#!python

#
# Perl Weekly Challenge 246
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-246/>
#

import sys
from itertools import count

# task implementation
def main( argv ):
    nums = list( map( int, argv ) )
    ko = len( nums ) - 2

    for current_index in range( 2, len( nums ) ):
        for p in count( start = 1 ):
            for q in count( start = 1 ):
                if nums[ current_index ] == ( p * nums[ current_index - 2 ] + q * nums[ current_index - 1 ] ) \
                  or nums[ current_index ] == ( p * -1 * nums[ current_index - 2 ] + q * nums[ current_index - 1 ] ) \
                  or nums[ current_index ] == ( p * -1 * nums[ current_index - 2 ] + q * -1 * nums[ current_index - 1 ] ) \
                  or nums[ current_index ] == ( p * nums[ current_index - 2 ] + q * -1 *  nums[ current_index - 1 ] ):
                    ok = True
                    ko = ko - 1
                    break

            if ok:
                break

    if ko == 0:
        print( 'True' )
    else:
        print( 'False' )



# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


