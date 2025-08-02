#!python

#
# Perl Weekly Challenge 280
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-280>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    string = args[ 0 ]
    for l in string:
        if len( list( filter( lambda x: x == l, string ) ) ) > 1:
            return l


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
