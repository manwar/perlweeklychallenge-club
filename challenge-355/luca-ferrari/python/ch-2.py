#!python

#
# Perl Weekly Challenge 355
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-355>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    nums = list( map( int, args ) )

    ok = False
    for i in range( 1, len( nums ) - 1 ):
        left  = nums[ 0 : i ]
        left2 = nums[ 0 : i ]
        left2.sort()
        right  = nums[ i : ]
        right2 = nums[ i : ]
        right2.sort( reverse = True )

        if cmp( left, left2 ) and cmp( right, right2 ):
            return True

    return False

def cmp( left, right ):
    if len( left ) != len( right ):
        return False

    for i in range(0, len( left ) ):
        if left[ i ] != right[ i ]:
            return False

    return True

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
