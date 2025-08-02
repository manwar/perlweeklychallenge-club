#!python

#
# Perl Weekly Challenge 257
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-257>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    output = []
    numbers = list( map( int, args ) )
    for current in numbers:
        output.append( len( list( filter( lambda x: x < current, numbers ) ) ) )

    return output


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
