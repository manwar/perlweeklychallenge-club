#!python

#
# Perl Weekly Challenge 349
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-349>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    h = 0
    v = 0

    for move in args[ 0 ]:
        if move == 'L' :
            h -= 1
        elif move == 'R':
            h += 1
        elif move == 'U':
            v += 1
        elif move == 'D':
            v -= 1

    return v == 0 and h == 0


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
