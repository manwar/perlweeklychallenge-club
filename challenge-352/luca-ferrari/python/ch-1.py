#!python

#
# Perl Weekly Challenge 352
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-352>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    found = []

    for i in range( 0, len( args ) ) :
        current = args[ i ]
        for j in range( i + 1, len( args ) ) :
            if re.match( current, args[ j ] ) :
                found.append( current )

    return found


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
