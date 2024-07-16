#!python

#
# Perl Weekly Challenge 278
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-278>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    word = args[ 0 ]
    c    = args[ 1 ]

    if not c in word:
        return word

    left = []

    for x in word:
        left.append( x )
        if x == c:
            break

    return ''.join( list( sorted( left ) ) ) + word[ len( left )  : len( word )  ]


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
