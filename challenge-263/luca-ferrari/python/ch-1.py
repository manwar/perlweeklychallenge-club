#!python

#
# Perl Weekly Challenge 263
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-263>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    k      = int( args[ 0 ] )
    nums   = list( map( int, args[ 1: ] ) )
    nums.sort()
    return list( filter( lambda x: nums[ x ] == k, range( 0, len( nums ) ) ) )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
