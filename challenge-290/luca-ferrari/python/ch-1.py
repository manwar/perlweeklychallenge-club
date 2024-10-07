#!python

#
# Perl Weekly Challenge 290
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-290>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    counter = 0
    args = list( map( int, args ) )

    for i in range( 0, len( args ) ):
        for j in range( i + 1, len( args ) ):
            if args[ i ] == ( 2 * args[ j ] ):
                counter +=1

    return counter > 0

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
