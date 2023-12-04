#!python

#
# Perl Weekly Challenge 246
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-246/>
#

import sys
import random

# task implementation
def main( argv ):
    values = []
    while len( values ) < 6:
        current_value = random.randint( 1, 49 )
        if not current_value in values:
            values.append( current_value )

    print( "\n".join( map( str, values ) ) )


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


