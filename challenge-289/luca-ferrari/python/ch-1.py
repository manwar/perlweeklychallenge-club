#!python

#
# Perl Weekly Challenge 289
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-289>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    sorted_nums = list( sorted( map( int, args ) ) )
    sorted_nums = sorted_nums[ ::-1 ]

    if len( sorted_nums ) >= 3:
        return sorted_nums[ 2 ]
    else:
        return sorted_nums[ 0 ]


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
