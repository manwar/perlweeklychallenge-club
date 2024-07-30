#!python

#
# Perl Weekly Challenge 280
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-280>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    pos = 0
    count = 0
    for needle in args[ 0 ]:
        if needle == '|':
            pos += 1
            continue
        elif needle == '*' and pos % 2 != 0:
            count += 1

    return count

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
