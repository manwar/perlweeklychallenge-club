#!python

#
# Perl Weekly Challenge 331
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-331>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    left  = args[ 0 ].lower()
    right = args[ 1 ].lower()

    diffs = 0

    if len( left ) != len( right ) :
        return False


    for i in range( 0, len( left ) ) :
        if left[ i ] != right[ i ] :
            diffs += 1


    return diffs <= 2

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
