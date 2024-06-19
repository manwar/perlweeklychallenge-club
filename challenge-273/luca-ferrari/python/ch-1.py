#!python

#
# Perl Weekly Challenge 273
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-273>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    s = args[ 0 ]
    c = args[ 1 ]

    return round( len( list( filter( lambda x: x == c, s ) ) ) / len( s ) * 100 )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
