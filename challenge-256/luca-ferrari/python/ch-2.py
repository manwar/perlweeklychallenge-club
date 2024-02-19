#!python

#
# Perl Weekly Challenge 256
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-256>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    left   = args[ 0 ]
    right  = args[ 1 ]
    output = ''

    max_index = max( len( left ), len( right ) )

    for i in range( 0, max_index ):
        if i < len( left ):
            output += left[ i ]
        if i < len( right ):
            output += right[ i ]

    return output


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
