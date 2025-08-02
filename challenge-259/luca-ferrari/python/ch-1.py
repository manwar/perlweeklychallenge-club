#!python

#
# Perl Weekly Challenge 259
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-259>
#

import sys
from datetime import date, timedelta

# task implementation
# the return value will be printed
def task_1( args ):
    day      = date.fromisoformat( args[ 0 ] )
    offset   = int( args[ 1 ] )
    holidays = list( map( lambda x: date.fromisoformat( x ), args[ 2: ] ) )
    one_day  = timedelta( days=1 )

    while offset > 0 :
        day += one_day

        while day.weekday() >= 6 or day.weekday() == 0:
            day += one_day

        while day in holidays :
            day += one_day

        offset -= 1

    return day


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
