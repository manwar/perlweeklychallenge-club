#!python

#
# Perl Weekly Challenge 348
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-348>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    lc     = 0
    rc     = 0
    middle = len( args[ 0 ] ) / 2
    index  = 0
    vowels = [ 'a', 'e', 'i', 'o', 'u' ]

    for c in args[ 0 ].lower() :
        index += 1

        if c in vowels :
            if index <= middle :
                lc += 1
            else :
                rc += 1

    return lc == rc



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
