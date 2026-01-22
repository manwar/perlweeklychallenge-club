#!python

#
# Perl Weekly Challenge 357
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-357>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    num = int( args[ 0 ] )
    perms = []

    for i in range( 1, num + 1 ) :
        for j in range( 1, num + 1 ) :
            perms.append( [ i, j ] )

    fractions = {}
    for current in perms :
        n = current[ 0 ]
        d = current[ 1 ]
        v = str( n / d )

        if ( not v in fractions ) or  ( v in fractions and fractions[ v ][ 0 ] > n ):
            fractions[ v ] = [ n , d ]

    for k in sorted( fractions.keys() ):
        current = fractions[ k ]
        print( '%d/%d' % ( current[ 0 ], current[ 1 ] ) )



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
