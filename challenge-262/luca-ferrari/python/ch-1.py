#!python

#
# Perl Weekly Challenge 262
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-262>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    nums = list( map( int, args ) )
    positives = len( list( filter( lambda x: True if x >= 0 else False, nums ) ) )
    negatives = len( list( filter( lambda x: True if x < 0  else False, nums ) ) )

    return positives if positives >= negatives else negatives


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
