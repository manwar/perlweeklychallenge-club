#!python

#
# Perl Weekly Challenge 269
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-269>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    nums = list( map( int, args ) )

    left = []
    right = []

    left.append( nums[ 0 ] )
    right.append( nums[ 1 ] )

    i = 2
    while i < len( nums ):
        if left[ len( left ) - 1 ] > right[ len( right ) - 1 ] :
            left.append( nums[ i ] )
        else:
            right.append( nums[ i ] )
        i += 1

    return ( left, right )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
