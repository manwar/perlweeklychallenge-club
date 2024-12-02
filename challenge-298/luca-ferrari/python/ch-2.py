#!python

#
# Perl Weekly Challenge 298
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-298>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    intervals = []
    current   = []
    other     = []
    indexes   = []

    for x in args:
        if x == 'x':
            intervals.append( current )
            current = []
            continue

        current.append( int( x ) )

    intervals.append( current )
    print( intervals )

    for current_index in range( 0, len( intervals ) ):

        min_value = 999999
        min_index = -1

        for other_index in range( 0, len( intervals ) ):
            if other_index == current_index:
                continue


            current = intervals[ current_index ]
            other   = intervals[ other_index ]

            if other[ 0 ] >= current[ 1 ]:
                if min_value > other[ 0 ]:
                    min_value = other[ 0 ]
                    min_index = other_index

        indexes.append( min_index )


    return indexes

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
