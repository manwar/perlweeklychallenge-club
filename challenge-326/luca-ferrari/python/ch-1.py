#!python

#
# Perl Weekly Challenge 326
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-326>
#

import sys
from datetime import datetime, date

# task implementation
# the return value will be printed
def task_1( args ):
    begin = datetime.strptime( args[ 0 ], "%Y-%m-%d").date()
    end   = date( begin.year, 1, 1 )
    return abs( ( end - begin ).days )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
