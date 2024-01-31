#!python

#
# Perl Weekly Challenge 254
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-254>
#

import sys
import math

# task implementation
# the return value will be printed
def task_1( args ):
    num = int( args[ 0 ] )
    for i in range( 2, int( math.sqrt( num ) ) ):
        if ( i ** 3 ) == num:
            return True

    return False


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
