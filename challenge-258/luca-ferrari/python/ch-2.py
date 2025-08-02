#!python

#
# Perl Weekly Challenge 258
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-258>
#

import sys


# task implementation
# the return value will be printed
def task_2( args ):
    k = int( args[ 0 ] )
    nums = list( map( int, args[ 1: ] ) )

    def is_index_ok( v, k ):
        b = '{0:08b}'.format( v )
        count = sum( map( int, list( '{0:08b}'.format( v ) ) ) )
        return count == k

    indexes = list( filter( lambda i: is_index_ok( i, k ),
                            range(0, len( nums ) ) ) )

    summy = 0
    for i in indexes:
        summy += nums[ i ]

    return summy


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
