#!python

#
# Perl Weekly Challenge 312
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-312>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    typing = args[ 0 ]
    letters = {}
    secs = 0
    position = 0
    next_position = 0

    for x in alphabet :
        letters[ x ] = position
        position += 1

    for c in typing :
        next_position = letters[ c ]
        clock = abs( next_position - position )
        anti  = abs( len( alphabet ) - next_position - position )
        position = next_position

        secs += 1
        if clock > anti :
            secs += anti
        else :
            secs += clock

    return secs


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
