#!python

#
# Perl Weekly Challenge 240
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-240/>
#

import sys

# task implementation
def main( argv ):
    letters = list( map( lambda x: x[ 0 ].casefold(), argv[1:] ) )
    check_chars = list( argv[ 0 ] )

    if len( check_chars ) != len( letters ):
        print( 'False' )
        return False

    for index in range( len( argv[ 0 ] ) ):
        if argv[ 0 ][ index ].casefold() != letters[ index ]:
            print( 'False' )
            return False

    print( 'True' )
    return True


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


