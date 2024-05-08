#!python

#
# Perl Weekly Challenge 268
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-268>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    left = []
    right = []

    left  = list( map( int, args[ 0 : args.index( "|" ) ] ) )
    right = list( map( int, args[ args.index( "|" ) + 1 : ] ) )

    left.sort()
    right.sort()

    diffs = []
    for index in range( 0, len( left ) ):
        d = left[ index ] - right[ index ]
        if not d in diffs:
            diffs.append( d )

    if len( diffs ) == 1:
        return diffs[ 0 ]
    else:
        return None



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
