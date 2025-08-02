#!python

#
# Perl Weekly Challenge 260
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-260>
#

import sys
import array
from itertools import permutations

# task implementation
# the return value will be printed
def task_2( args ):
    word = args[ 0 ]
    words = []
    engine = permutations( list( word ) )
    for p in list( engine ):
        words.append( ''.join( p ) )

    words = sorted( words )
    for i in range( 0, len( words ) ):
        if words[ i ] == word:
            return i + 1


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
