#!python

#
# Perl Weekly Challenge 331
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-331>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    size = 0
    for w in args[ 0 ].split() :
        if len( w ) > 0 :
            size = len( w )

    return size


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
