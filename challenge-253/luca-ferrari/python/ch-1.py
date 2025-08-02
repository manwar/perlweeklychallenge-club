#!python

#
# Perl Weekly Challenge 253
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    separator   = args[ 0 ];
    split_words = []
    for i in range( 1, len( args ) ):
        current_words = args[ i ]
        for w in re.split( "[%s]" % separator, current_words ):
            split_words.append( w )

    return ','.join( split_words )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
