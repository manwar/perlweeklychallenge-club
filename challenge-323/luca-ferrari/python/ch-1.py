#!python

#
# Perl Weekly Challenge 323
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-323>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    value = 0

    for operation in args:
        if '++' in operation:
            value += 1
        elif '--' in operation:
            value -= 1

    return value


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
