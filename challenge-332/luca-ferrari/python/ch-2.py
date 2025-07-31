#!python

#
# Perl Weekly Challenge 332
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-332>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    bag = {}
    for c in args[ 0 ]:
        if not c in bag:
            bag[ c ] = 0
        bag[ c ] = bag[ c ] + 1

    for x in bag:
        if bag[ x ] > 1:
            return False

    return True


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
