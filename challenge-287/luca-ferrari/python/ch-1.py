#!python

#
# Perl Weekly Challenge 287
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-287>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    password = args[ 0 ]
    lc    = re.compile( '[a-z]' )
    uc    = re.compile( '[A-Z]' )
    dg    = re.compile( '[0-9]' )
    wrong = re.compile( '(.)\\1\\1' )
    return lc.search( password ) and uc.search( password ) and dg.search( password ) and wrong.search( password ) is None

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
