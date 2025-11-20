#!python

#
# Perl Weekly Challenge 348
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-348>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    source = args[ 0 ]
    target = args[ 1 ]
    multi  = [ 60, 1 ]
    index  = 0

    src_mins = 0
    dst_mins = 0


    for p in source.split( ':' ) :
        src_mins += int( p ) * multi[ index ]
        index    += 1

    index = 0
    for p in target.split( ':' ) :
        dst_mins += int( p ) * multi[ index ]
        index    += 1

    op_list = []
    operations = [ 60, 15, 10, 5, 1 ]
    for op in operations :
        while dst_mins - src_mins >= op :
            src_mins += op
            op_list.append( op )

    return len( op_list )

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
