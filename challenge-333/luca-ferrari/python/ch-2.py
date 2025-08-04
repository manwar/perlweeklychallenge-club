#!python

#
# Perl Weekly Challenge 333
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-333>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    result = []
    limit  = len( args )
    index  = 0

    while limit > 0:
        current = int( args[ index ] )
        index   = index + 1
        result.append( current )
        limit = limit - 1
        if limit == 0:
            break

        if current == 0:
            result.append( current )
            limit = limit - 1
            if limit == 0:
                break

    return result

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
