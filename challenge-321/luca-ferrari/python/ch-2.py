#!python

#
# Perl Weekly Challenge 321
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-321>
#

import sys
import re

# task implementation
# the return value will be printed
def task_2( args ):
    left  = args[ 0 ]
    right = args[ 1 ]

    left  = re.sub( '.[#]', '', left )
    right = re.sub( '.[#]', '', right )

    return left == right


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
