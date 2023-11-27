#!python

#
# Perl Weekly Challenge 244
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-244/>
#

import sys

# task implementation
def main( argv ):
    nums = list( map( int, argv ) )
    result = []

    for current in nums:
        result.append( len( list( filter( lambda x: x > current, nums ) ) ) )

    print( ", ".join( map( str, result ) ) )


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


