#!python

#
# Perl Weekly Challenge 257
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-257>
#

import sys

# task implementation
# the return value will be printed
def task_2( numbers ):

    ok = False
    zero_rows = []
    leadings  = []

    for row in range( 0, len( numbers ) ):
        first_in_row = None

        for col in range( 0, len( numbers[ row ] ) ):
            if numbers[ row ][ col ] == 0:
                continue

            if first_in_row != None:
                continue

            first_in_row = numbers[ row ][ col ]


            if first_in_row != 1:
                return False

            leadings.append( { 'row' : row, 'col' : col } )
            if len(leadings) <= 1:
                continue

            if leadings[ -2 ][ 'row' ] != ( row - 1 ) and leadings[ -2 ][ 'col' ] >= col:
                return False

        if first_in_row == None:
            zero_rows.append( row )

            if len( zero_rows ) <= 1:
                continue
            if zero_rows[ -2 ] != ( row - 1 ):
                return False
        elif first_in_row == 1:
            if len( leadings ) <= 1:
                continue
            if leadings[ -2 ][ 'row' ] != leadings[ -1 ][ 'row' ] -1 and leadings[ -2 ][ 'col' ] >= leadings[ -1 ][ 'col' ]:
                return False

    return True


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( [ [0,1,0], [0,0,1], [0,0,0] ] ) )
