#!python

#
# Perl Weekly Challenge 243
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-243/>
#

import sys
from functools import reduce

# task implementation
def main( argv ):
    nums = list( map( int, argv ) )
    sum = 0


    for current in nums:
        sum = sum + reduce( lambda a,b: a + b, list( map( lambda x: int( current /x ), nums ) ) )

    print( sum )

# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


