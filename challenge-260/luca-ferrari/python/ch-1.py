#!python

#
# Perl Weekly Challenge 260
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-260>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    nums = list( map( int, args ) )
    bag = {}

    for n in nums:
        occurrencies = len( list( filter( lambda x: x == n, nums ) ) )
        if not n in bag:
            bag[ n ] = occurrencies


    for o in bag.values():
        if len( list( filter( lambda x: x == o, bag.values() ) ) ) > 1:
            return 0

    return 1


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
