#!python

#
# Perl Weekly Challenge 250
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-250/>
#

import sys
import re

# task implementation
def main( argv ):
    max = 0
    is_num = re.compile( '^\d+$' )
    for current in argv:
        v = 0

        if is_num.match( current ) is None:
            v = len( current )
        else:
            v = int( current )

        if v > max:
            max = v

    return max


# invoke the main without the command itself
if __name__ == '__main__':
    print( main( sys.argv[ 1: ] ) )
