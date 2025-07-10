#!python

#
# Perl Weekly Challenge 329
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-329>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    string = args[ 0 ]

    numbers = []
    pattern = re.compile( r'\d+' )
    for i in pattern.findall( string ) :
        if not i in numbers :
            numbers.append( i )

    return numbers

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
