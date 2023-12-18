#!python

#
# Perl Weekly Challenge 247
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-247/>
#

import sys
from random import randrange, choice

# task implementation
def main( argv ):
    santas    =  argv.copy()
    receivers =  argv.copy()

    while len( santas ) >= 0 :
        current_santa = santas[ randrange( 0, len( santas )  ) ]
        current_receiver = receivers[ randrange( 0, len( receivers )  ) ]

        if ( current_santa == current_receiver ):
            continue

        print( current_santa, " -> ", current_receiver )
        santas.remove( current_santa )
        receivers.remove( current_receiver )

        if len( santas ) == 0:
            break


# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


