#!python

#
# Perl Weekly Challenge 325
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-325>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    bits  = list( map( int, args ) )
    f_max = 0
    c_max = 0

    for d in bits:
        if d == 1:
            c_max += 1
        else:
            if c_max > f_max :
                f_max = c_max

            c_max = 0

    return f_max



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
