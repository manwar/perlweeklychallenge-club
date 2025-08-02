#!python

#
# Perl Weekly Challenge 267
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-267>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    nums = list( map( int, args ) )
    zeros = list( filter( lambda x: x == 0, nums ) )
    negatives = list( filter( lambda x: x < 0, nums ) )
    if len( zeros ) > 0:
        return 0
    elif len( negatives ) % 2 != 0:
        return -1
    else:
        return 1


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
