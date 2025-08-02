#!python

#
# Perl Weekly Challenge 265
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-265>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    pct = {}
    for x in args:
        if not x in pct:
            pct[ x ] = 0
        pct[ x ] += 1 / len( args )

    found = None
    for x in pct:
        if pct[ x ] >= ( 33 / 100 ) and ( found is None or int( x ) < found ):
            found = int( x )

    return found

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
