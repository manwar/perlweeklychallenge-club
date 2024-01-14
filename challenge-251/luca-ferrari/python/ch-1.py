#!python

#
# Perl Weekly Challenge 251
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-251/>
#

import sys

# task implementation
def main( argv ):
    sum = 0
    for i in range( 0, len( argv ) - 1 ):
        if i % 2 != 0:
            continue
        sum += int( argv[ i ] + argv[ i + 1 ] )

    return sum


# invoke the main without the command itself
if __name__ == '__main__':
    print( main( sys.argv[ 1: ] ) )
