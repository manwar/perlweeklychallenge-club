#!python

#
# Perl Weekly Challenge 341
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-341>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    sentence = args[ 0 ]
    keys     = args[ 1 : ]
    result   = []

    for word in sentence.split():
        found = False

        for k in keys:
            if k in word:
                found = True

        if not found:
            result.append( word )

    return ' '.join( result )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
