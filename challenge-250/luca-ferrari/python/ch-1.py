#!python

#
# Perl Weekly Challenge 250
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-250/>
#

import sys

# task implementation
def main( argv ):
    for i in range(0,len(argv)):
        if int(i) % 10 == int( argv[ i ] ):
            return i

    return -1


# invoke the main without the command itself
if __name__ == '__main__':
    print( main( sys.argv[ 1: ] ) )
