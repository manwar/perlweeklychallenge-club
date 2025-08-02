#!python

#
# Perl Weekly Challenge 272
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-272>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    score    = 0
    string   = args[ 0 ]
    previous = None

    for x in string:
        if previous is not None:
            diff = ord( x ) - ord( previous )
            if diff < 0:
                diff *= -1

            score += diff

        previous = x

    return score


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
