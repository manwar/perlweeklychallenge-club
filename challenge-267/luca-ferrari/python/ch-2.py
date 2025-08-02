#!python

#
# Perl Weekly Challenge 267
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-267>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    phrase = args[ 0 ]
    widths = {}

    index = 1
    for letter in 'abcdefghiljkmnopqrstuvwxyz':
        widths[ letter ] = int( args[ index ] )
        index += 1

    lines  = 1
    pixels = 0

    for letter in phrase:
        current_width = widths[ letter ]
        if pixels + current_width > 100:
            pixels = 0
            lines += 1

        pixels += current_width

    return [ lines, pixels ]


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
