#!python

#
# Perl Weekly Challenge 252
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-252/>
#

import sys

# task implementation
# the return value will be printed
def main( argv ):
    size = int( argv[ 0 ] )
    nums = []

    if size % 2 == 0:
        for i in range( 1, size / 2 ):
            nums.append( i )
            nums.append( i * -1 )
    else:
        for i in range( 1, int( ( size - 1 ) / 2 ) ):
            nums.append( i )
            nums.append( i * -1 )

        next = max( nums ) + 1
        nums.append( next )
        nums.append( next + 1 )
        nums.append( ( next + next + 1 ) * -1 )

    return nums



# invoke the main without the command itself
if __name__ == '__main__':
    print( main( sys.argv[ 1: ] ) )

