#!python

#
# Perl Weekly Challenge 255
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-254>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    origin = args[ 0 ]
    shuffled = args[ 1 ]
    if len( shuffled ) != len( origin ) + 1:
        return "Shuffled string must be one character longer than original string"

    classification = {}

    for needle in shuffled:
        if not needle in classification:
            classification[ needle ] = 0

        classification[ needle ] += 1

    for needle in origin:
        classification[ needle ] -= 1
        if classification[ needle ] <= 0:
            del classification[ needle ]

    return list( classification.keys() )[ 0 ]


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
