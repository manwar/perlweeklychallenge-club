#!python

#
# Perl Weekly Challenge 290
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-290>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    numbers = list( map( int, args ) )
    payload = numbers[ -1 ]
    checksum = 0

    numbers = list( map( lambda x: x * 2, numbers[ 0 : -1 ] ) )
    last_seen = Nil
    for v in numbers:
        if last_seen is not Nil and last_seen == v:
	    continue

        if v > 9:
            s = 0
            for x in str( v ):
                s += int( x )
            v = s

        checksum += v
        last_seen = v

    if ( checksum + payload ) % 10 == 0:
        return True
    else:
        return False



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
