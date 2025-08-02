#!python

#
# Perl Weekly Challenge 276
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-276>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    nums      = list( map( int, args ) )
    frequency = {}
    max_freq  = 0

    for x in nums:
        freq = len( list( filter( lambda v: v == x, nums ) ) )
        if freq > max_freq:
            max_freq = freq

        if not freq in frequency:
            frequency[ freq ] = []

        if not x in frequency[ freq ]:
            frequency[ freq ].append( x )


    return len( frequency[ max_freq ] )

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
