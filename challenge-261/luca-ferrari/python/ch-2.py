#!python

#
# Perl Weekly Challenge 261
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-261>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    start = int( args[ 0 ] )
    nums  = args[ 1: ]
    while len( list( filter( lambda x: x == str( start ), nums ) ) ) > 0:
        start *= 2

    return start


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
