#!python

#
# Perl Weekly Challenge 255
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-254>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    paragraph = args[ 0 ]
    banned    = args[ 1 ]
    classification = {}
    for w in paragraph.split():
        if w != banned:
            if not w in classification:
                classification[ w ] = 0
            classification[ w ] += 1

    return sorted( classification.items() )[ -1 ][ 0 ]

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
