#!python

#
# Perl Weekly Challenge 272
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-272>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    return args[ 0 ].replace( '.', '[.]' )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
