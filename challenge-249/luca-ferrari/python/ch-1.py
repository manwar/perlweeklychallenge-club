#!python

#
# Perl Weekly Challenge 249
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-249/>
#

import sys

# task implementation
def main( argv ):
    classification = {}
    for i in argv:
        if not i in classification:
            classification[ i ] = 0
        classification[ i ] += 1

    pairs = []
    for k in classification:
        while classification[ k ] >= 2:
            pairs.append( [ k, k ] )
            classification[ k ] -= 2

    for p in pairs:
        print( ", ".join( p ) )


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


