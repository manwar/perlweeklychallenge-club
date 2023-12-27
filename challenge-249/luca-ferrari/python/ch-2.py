#!python

#
# Perl Weekly Challenge 249
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-249/>
#

import sys
from itertools import permutations

# task implementation
def main( argv ):
    nums = range( 0, len( argv[ 0 ] ) )


    for perm in permutations( nums ):
        ok = True
        for i in range( 0, len( perm ) - 1 ):
            if argv[ 0 ][ i ] == 'D' and perm[ i ] > perm[ i + 1 ]:
                ok = False
                break
            elif argv[ 0 ][ i ] == 'I' and perm[ i ] < perm[ i + 1 ]:
                ok = False
                break

        if ok:
            print( ",".join( map( str, perm ) ) )
            return


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


