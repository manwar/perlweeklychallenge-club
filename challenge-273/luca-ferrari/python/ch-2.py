#!python

#
# Perl Weekly Challenge 273
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-273>
#

import sys
import re

# task implementation
# the return value will be printed
def task_2( args ):
    s = args[ 0 ]
    p1 = re.compile( 'b' )
    p2 = re.compile( 'b.*a' )
    return p1.search( s ) and not p2.search( s )




# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
