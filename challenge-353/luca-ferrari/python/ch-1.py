#!python

#
# Perl Weekly Challenge 353
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-353>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    regex = re.compile( r'\s+' )
    return max( list( map( lambda x: len( regex.split( x ) ), args ) ) )



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
