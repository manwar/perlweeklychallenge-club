#!python

#
# Perl Weekly Challenge 278
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-278>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    sorted_words = {}
    pattern      = re.compile( "^([a-zA-Z]+)(\\d)+$" )

    for w in args:
        m = pattern.match( w )
        sorted_words[ str( m.group( 2 ) ) ] = m.group( 1 )

    sorted_words = dict( sorted( sorted_words.items() ) )
    return ' '.join( sorted_words.values() )



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
