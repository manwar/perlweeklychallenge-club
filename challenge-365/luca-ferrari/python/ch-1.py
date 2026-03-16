#!python

#
# Perl Weekly Challenge 365
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-365>
#

import sys
import string

# task implementation
# the return value will be printed
def task_1( args ):
    word = args[ 0 ]
    base = int( args[ 1 ] )

    alphabet = list( string.ascii_lowercase )

    result = ""
    for v in word:
        result += str( alphabet.index( v ) + 1 )

    summy = 0
    current = 0
    for v in result:
        summy += int( v )

    while base > 0:
        current = 0
        for v in str( summy ):
            current += int( v )

        summy = current
        base  = base - 1


    return summy

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
