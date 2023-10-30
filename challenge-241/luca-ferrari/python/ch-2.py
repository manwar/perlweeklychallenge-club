#!python

#
# Perl Weekly Challenge 241
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-241/>
#

import sys

def get_primes( n ):
    primes = []
    for i in range(2, n):
        while n % i == 0:
            primes.append( i )
            n /= i

        if n == 1:
            break

    return primes

# task implementation
def main( argv ):
    sorted_dict = {}
    for current in argv:
        counter = len( get_primes( int( current ) ) )
        if not counter in sorted_dict:
            sorted_dict[ counter ] = []

        sorted_dict[ counter ].append( current )

    for key in sorted( sorted_dict ):
        for v in sorted_dict[ key ]:
            print( v )


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


