#!python

#
# Perl Weekly Challenge 256
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-256>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    max = 0
    for w in args:
        count = len( list( filter( lambda rw: rw == ''.join( reversed( w ) ), args ) ) )
        if count > max:
            max = count

    return max


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
