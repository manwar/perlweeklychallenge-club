#!python

#
# Perl Weekly Challenge 325
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-325>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    prices     = list( map( int, args ) )
    new_prices = []

    for i in range( 0, len( prices ) ) :
        current  = prices[ i ]
        next_min = list( filter( lambda x: x < current, prices[ i + 1 : ] ) )
        if len( next_min ) > 0 :
            next_min = next_min[ 0 ]
        else:
            next_min = 0

        new_prices.append( current - next_min )

    return new_prices



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
