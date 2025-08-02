#!python

#
# Perl Weekly Challenge 275
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-275>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    string = args[ 0 ]
    previous = None
    result   = ""

    for c in string:
        if c.isdigit():
            c = chr( int( c ) + 97 )
        else:
            previous = c

        result += c

    return result


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
