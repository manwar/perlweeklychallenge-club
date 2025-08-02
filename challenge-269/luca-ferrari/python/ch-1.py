#!python

#
# Perl Weekly Challenge 269
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-269>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    nums = list( map( int, args ) )
    couples = []

    for i in range( 0, len( nums ) ):
        for j in range ( i + 1, len( nums ) ):
            if ( nums[ i ] | nums[ j ] ) % 2 == 0 :
                couples.append( nums[ i ] )
                couples.append( nums[ j ] )

    return couples


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
