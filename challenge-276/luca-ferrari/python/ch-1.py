#!python

#
# Perl Weekly Challenge 276
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-276>
#

import sys
from itertools import combinations

# task implementation
# the return value will be printed
def task_1( args ):
    hours = list( map( int, args ) )
    return list( filter( lambda v: ( v[ 0 ] + v[ 1 ] ) % 24 == 0,  list( combinations( hours, 2 ) ) ) )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
