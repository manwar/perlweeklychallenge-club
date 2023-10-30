#!python

#
# Perl Weekly Challenge 240
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-240/>
#

import sys

# task implementation
def main( argv ):
    new_array = []
    for index in range( len( argv ) ):
        new_array.insert( index, argv[ int( argv[ index ] ) ] )

    print( ','.join( new_array ) )


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


