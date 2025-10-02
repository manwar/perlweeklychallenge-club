#!python

#
# Perl Weekly Challenge 341
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-341>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    word   = args[ 0 ]
    prefix = args[ 1 ]

    index = word.index( prefix )

    return word[ index : 0 : -1 ] + word[ index : ]


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
