#!python

#
# Perl Weekly Challenge 242
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-242/>
#

import sys

# task implementation
def main( argv ):
    left = []
    right = []
    is_left = True
    for current in argv:
        if current != '|':
            if ( is_left ):
                left.append( int( current ) )
            else:
                right.append( int( current ) )
        else:
            is_left = False

    missing_left = []
    missing_right = []

    for current in left:
        if not current in right:
            missing_left.append( current )

    for current in right:
        if not current in left:
            missing_right.append( current )

    print( ",".join( map( str, missing_left ) ) )
    print( ",".join( map( str, missing_right ) ) )


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


