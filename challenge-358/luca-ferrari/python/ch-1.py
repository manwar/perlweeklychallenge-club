#!python

#
# Perl Weekly Challenge 358
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-358>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    max = 0
    for x in args:
        current = 0
        try:
            current = int( x )
        except:
            current = len( x )

        if current > max:
            max = current

    return max



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
