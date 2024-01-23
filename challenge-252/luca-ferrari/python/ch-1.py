#!python

#
# Perl Weekly Challenge 252
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-252/>
#

import sys

# task implementation
# the return value will be printed
def main( argv ):
    nums = list( map( int, argv ) )
    sum = 0
    for i in range( 0, len( nums ) ):
        if len( nums ) % ( i + 1 ) == 0:
            sum += nums[ i ] ** 2;

    return sum


# invoke the main without the command itself
if __name__ == '__main__':
    print( main( sys.argv[ 1: ] ) )

