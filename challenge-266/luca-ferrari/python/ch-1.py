#!python

#
# Perl Weekly Challenge 266
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-266>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    left  = args[ 0 ]
    right = args[ 1 ]

    bag_left  = {}
    bag_right = {}

    # classify
    for w in left.split():
        c = 1
        w = w.lower()
        if w in bag_left:
            c += bag_left[ w ]

        bag_left[ w ] = c

    for w in right.split():
        c = 1
        w = w.lower()
        if w in bag_right:
            c += bag_right[ w ]

        bag_right[ w ] = c

    words = []
    for w in bag_left:
        if bag_left[ w ] == 1 and not w in bag_right:
            words.append( w )

    for w in bag_right:
        if bag_right[ w ] == 1 and not w in bag_left:
            words.append( w )

    return words


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
