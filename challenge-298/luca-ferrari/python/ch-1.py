#!python

#
# Perl Weekly Challenge 298
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-298>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    matrix = []
    row    = 0
    col    = 0

    # transform into a matrix
    line = []
    for x in args:
        if x == 'x':
            matrix.append( line )
            line = []
            continue

        line.append( int( x ) )



    max_size = 0

    for row in range( 0, len( matrix ) ):
        for col in range( 0, len( matrix[ row ] ) ):
            if matrix[ row ][ col ] != 1:
                continue

            size  = 1
            found = True

            while found and ( row + size ) < len( matrix ) and ( col + size ) < len( matrix[ row ] ):
                for rr in range( row, row + size ):
                    for cc in range( col, col + size ):
                        if matrix[ rr ][ cc ] != 1:
                            found = False
                            break

                    if not found:
                        break

                if size > max_size:
                    max_size = size

                size = size + 1

    return max_size

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
