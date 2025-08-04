#!python

#
# Perl Weekly Challenge 333
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-333>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    coords = []
    for i in range( 0, len( args ) - 1 ):
        if i % 2 != 0:
            continue

        x = int( args[ i ] )
        y = int( args[ i + 1 ] )

        current = {}
        current[ 'x' ] = x
        current[ 'y' ] = y

        coords.append( current )

    first  = coords[ 0 ]
    second = coords[ 1 ]


    for i in range( 2, len( coords ) ):
        current = coords[ i ]
        if ( ( current[ 'x' ] - first[ 'x' ] ) * ( first[ 'y' ] - second[ 'y' ] ) ) != ( ( current[ 'y' ] - second[ 'y' ] ) * ( first[ 'x' ] - second[ 'x' ] ) ):
            return False

    return True



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
