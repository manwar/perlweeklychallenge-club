#!python

#
# Perl Weekly Challenge 330
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-330>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    string = args[ 0 ]

    regexp = re.compile( r'[a-z][0-9]' )


    while regexp.search( string ) is not None:
        string = re.sub( r'[a-z][0-9]', '', string )

    return string

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
