#!python

#
# Perl Weekly Challenge 358
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-358>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    src      = args[ 0 ]
    value    = int( args[ 1 ] )
    result   = ""
    alphabet = list( 'abcdefghijklmnopqrstuvwxyz' )

    for c in src:
        index = ( value + alphabet.index( c ) ) % len( alphabet )
        result += alphabet[ index ]

    return result


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
