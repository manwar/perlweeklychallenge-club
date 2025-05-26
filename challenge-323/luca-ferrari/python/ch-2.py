#!python

#
# Perl Weekly Challenge 323
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-323>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    income = int( args[ 0 ] )
    taxes = list( map( int, args[ 1: ] ) )
    value = 0
    last = 0

    for i in range( 0, len( taxes ) - 1 ) :
        if i % 2 == 0:
            continue


        up_to = taxes[ i ]
        pct   = taxes[ i + 1 ]

        if last > up_to:
            continue

        value += min( up_to, income ) * pct / 100

    return value

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
