#!python

#
# Perl Weekly Challenge 265
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-265>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    args        = list( map( lambda x: x.lower(), args ) )
    needle      = args[ 0 ]
    words       = args[ 1: ]
    found_words = []

    letters = {}
    for l in needle:
        if l == ' ' or l.isdigit():
            continue

        if not l in letters:
            letters[ l ] = 0
        letters[ l ] += 1

    for current in words:
        ok = True
        for letter in letters:
            if letters[ l ] > len( list( filter( lambda x: x == l, current ) ) ):
                ok = False
                break
        if ok:
            found_words.append( current )

    found_words.sort(key = lambda x: len( x ) )
    return found_words[ 0 ]

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
