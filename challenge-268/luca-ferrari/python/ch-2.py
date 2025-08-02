#!python

#
# Perl Weekly Challenge 268
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-268>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    sorted = list( map( int, args ) )
    sorted.sort()

    result = []

    for i in range( 0, len( sorted ) ):
        if i % 2 != 0:
            continue

        left  = sorted[ i ]
        right = sorted[ i + 1 ]

        result.append( left if left > right else right )
        result.append( left if right > left else right )

    return result


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
