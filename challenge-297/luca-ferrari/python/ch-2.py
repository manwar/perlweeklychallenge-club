#!python

#
# Perl Weekly Challenge 297
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-297>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    nums = list( map( int, args ) )
    swaps = 0

    f_index = int( list( filter( lambda i : nums[ i ] == 1, range( 0, len( nums ) ) ) )[ 0 ] )
    l_index = int( list( filter( lambda i : nums[ i ] == len( nums ), range( 0, len( nums ) ) ) )[ 0 ] )

    swaps += f_index
    if f_index < l_index:
        swaps += len( nums ) - l_index
    else:
        swaps += len( nums ) - l_index - ( f_index - l_index )

    return swaps - 1


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
