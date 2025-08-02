#!python

#
# Perl Weekly Challenge 271
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-271>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    binary = {}

    for v in args:
        b = "{0:08b}".format( int( v ) )
        c = 0
        for o in b:
            if o == '1':
                c += 1

        if not c in binary:
            binary[ c ] = []
        binary[ c ].append( int( v ) )
        binary[ c ] = list( sorted( binary[ c ] ) )

    binary = dict( sorted( binary.items() ) )
    result = []
    for b in binary:
        for v in binary[ b ]:
            result.append( v )

    return result


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
