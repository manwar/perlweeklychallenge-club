#!python

#
# Perl Weekly Challenge 266
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-266>
#

import sys

# task implementation
# the return value will be printed
def task_2( matrix ):
    size = len( matrix[ 0 ] )
    for row in range( 0, size ):
        for col in range( 0, size ):
            if row == col or col == size - row - 1:
                if matrix[ row ][ col ] == 0:
                    return 'False'
            elif matrix[ row ][ col ] != 0:
                return 'False'
    return 'True'



# invoke the main without the command itself
if __name__ == '__main__':
    matrix = [
        [1, 0, 0, 2],
        [0, 3, 4, 0],
        [0, 5, 6, 0],
        [7, 0, 0, 1],
    ]
    print( task_2( matrix ) )
