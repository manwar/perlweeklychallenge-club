#!python

#
# Perl Weekly Challenge 287
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-287>
#

import sys
import re

# task implementation
# the return value will be printed
def task_2( args ):
    number = args[ 0 ]
    good = re.compile( '^[+-]?\\d+([.]\\d+)?(E[+-]?\\d+)?$' )
    return good.match( number ) is not None

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
