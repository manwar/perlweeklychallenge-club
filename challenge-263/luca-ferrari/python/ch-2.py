#!python

#
# Perl Weekly Challenge 263
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-263>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    quantity = {}
    for index in range( 0, len( args ) - 1 ):
        if index % 2 == 1:
            continue

        item = args[ index ]
        qty  = int( args[ index + 1 ] )
        if item in quantity:
            quantity[ item ] += qty
        else:
            quantity[ item ] = qty

    return quantity


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
