#!python

#
# Perl Weekly Challenge 332
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-332>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    bins = []
    for c in re.split( r'[-]', args[ 0 ] ) :
        bins.append( "{0:b}".format( int( c ) ) )

    return '-'.join( bins )

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
