#!python

#
# Perl Weekly Challenge 262
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-262>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    k     = int( args[ 0 ] )
    nums  = list( map( int, args[ 1: ] ) )
    pairs = []

    for i in range( 0, len( nums ) ):
        for j in range( i + 1, len( nums ) ):
            if nums[ i ] != nums[ j ] or ( i * j ) % k != 0:
                continue
            else:
                pairs.append( [ i, j ] )

    return len( pairs )

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
