#!python

#
# Perl Weekly Challenge 297
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-297>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    bits = list( map( int, args ) )
    max_length = 0

    for start in range( 0, len( bits ) - 1 ):
        for end in range( start + 1 , len( bits ) ):
            current_length = end - start + 1
            ones  = len( list( filter( lambda x: x == 1, bits[ start : end ] ) ) )
            zeros = len( list( filter( lambda x: x == 0, bits[ start : end ] ) ) )

            if ones == zeros and current_length > max_length:
                max_length = current_length

    return max_length



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
