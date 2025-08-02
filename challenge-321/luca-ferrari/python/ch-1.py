#!python

#
# Perl Weekly Challenge 321
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-321>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    numbers = list( sorted( list( map( int, args ) ) ) )
    min_average = None

    for i in range( 0, len( numbers ) ):
        current = ( numbers[ i ] + numbers[ len( numbers ) - i - 1 ] ) / 2
        if min_average is None or current < min_average:
            min_average = current

    return min_average


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
