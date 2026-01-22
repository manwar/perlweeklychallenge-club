#!python

#
# Perl Weekly Challenge 357
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-357>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    k = 6174
    num = int( args[ 0 ] )
    iterations = 0

    while num != k :
        digits = [ int( i ) for i in str( num ) ]
        num = int( ''.join( list( map( str, sorted( digits, reverse = True ) ) ) ) ) - int( ''.join( list( map( str, sorted( digits ) ) ) ) )
        iterations += 1

    return iterations


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
