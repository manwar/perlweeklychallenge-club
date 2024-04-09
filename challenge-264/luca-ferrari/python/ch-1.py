#!python

#
# Perl Weekly Challenge 264
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-264>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    string = args[ 0 ]
    letters = []

    for letter in string:
        if not letter.isupper():
            continue

        engine = re.compile( letter.lower() )
        if not engine.search( string ):
            continue

        letters.append( letter )

    if len( letters ) <= 0:
        return ''

    letters.sort()
    return letters[ len( letters ) - 1 ]


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
