#!python

#
# Perl Weekly Challenge 322
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-322>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    string = args[ 0 ]
    size   = int( args[ 1 ] )
    chars  = []
    result = ""

    for c in string[::-1] :
        if c == '-':
            continue

        chars.append( c )

    counter = 1
    for c in chars:
        result  += c
        counter += 1

        if counter % size == 0:
            result += '-'

    return result[::-1]


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
