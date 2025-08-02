#!python

#
# Perl Weekly Challenge 326
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-326>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    nums = list( map( int, args ) )

    result = []

    for i in range( 0, len( nums ) - 1 ):
        if i % 2 != 0 :
            continue

        base  = nums[ i ]
        times = nums[ i + 1 ]

        for x in range(0, times ):
            result.append( base )

    return result


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
