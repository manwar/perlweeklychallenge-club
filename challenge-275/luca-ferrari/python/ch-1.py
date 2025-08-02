#!python

#
# Perl Weekly Challenge 275
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-275>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    sentence = args[ 0 ]
    keys     = args[ 1: ]
    words_ok = 0

    for word in sentence.lower().split():
        bad = 0
        for k in keys:
            k = k.lower()
            if k in word:
                bad += 1
                break

        if bad == 0:
            words_ok += 1

    return words_ok

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
