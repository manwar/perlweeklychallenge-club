#!python

#
# Perl Weekly Challenge 306
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-306>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    bits = list( map( int, args ) )
    primes = []

    def is_prime( n ):
        if n <= 1:
            return False

        for i in range( 2, n - 1 ):
            if n % i == 0:
                return False

        return True

    for i in range( 0, len( bits ) ):
        v = int( ''.join( list( map( str, bits[ 0 : i + 1 ] ) ) ), 2 )
        primes.append( is_prime( v ) )

    return primes


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
