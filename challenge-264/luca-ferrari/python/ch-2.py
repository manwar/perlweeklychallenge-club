#!python

#
# Perl Weekly Challenge 264
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-264>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    source  = []
    indexes = []
    target  = []
    swap    = False
    for v in args:
        if v == '|':
            swap = True
            continue
        else:
            if swap:
                indexes.append( int( v ) )
            else:
                source.append( int( v ) )


    for i in range( 0, len( indexes ) ):
        target_index = indexes[ i ]
        if len( target ) <= target_index:
            target.insert( target_index, source[ i ] )
        else:
            swapper = []
            swapper = target[ 0 : target_index ]
            swapper.append( source[ i ] )
            swapper += target[ target_index : ]
            target = swapper


    return target

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
