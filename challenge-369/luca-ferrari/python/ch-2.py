#!python

#
# Perl Weekly Challenge 369
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-369>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    string = args[ 0 ]
    size   = int( args[ 1 ] )
    filler = args[ 2 ]

    while len( string ) % size != 0 :
        string += filler

    parts = []
    index = 0
    while index < len( string ):
        parts.append( ''.join( list( string[ index : index + size ] ) ) )
        index += size

    return parts

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
