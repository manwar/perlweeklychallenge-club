#!python

#
# Perl Weekly Challenge 352
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-352>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    bits = list( map( int, args ) )
    found = []

    for i in range( 0, len( bits ) ) :
        current = ''.join( list( map( str, bits[ 0 : i + 1 ] ) ) )
        if int( current, 2 ) % 5 == 0 :
            found.append( current )


    return found


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
