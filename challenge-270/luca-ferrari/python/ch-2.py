#!python

#
# Perl Weekly Challenge 270
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-270>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    single = int( args[ 0 ] )
    double = int( args[ 1 ] )
    nums   = list( map( int, args[ 2: ] ) )

    # compute the current max
    max = None
    for v in nums:
        if not max or v > max:
            max = v

    need_operation = list( filter( lambda x: nums[ x ] < max, range( 0, len( nums ) ) ) )
    score = 0
    while len( need_operation ) > 0:
        if len( need_operation ) > 1 :
            score += double
            nums[ need_operation[ 0 ] ] += 1
            nums[ need_operation[ 1 ] ] += 1
            need_operation = need_operation[ 2: ]
        elif len( need_operation ) == 1:
            score += single
            nums[ need_operation[ 0 ] ] += 1
            need_operation = need_operation[ 2: ]


    return score



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
