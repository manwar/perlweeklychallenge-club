#!python

#
# Perl Weekly Challenge 258
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-258>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    sum = 0
    for n in args:
        if len( n ) % 2 == 0:
            sum += 1

    return sum


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
