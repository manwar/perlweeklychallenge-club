#!python

#
# Perl Weekly Challenge 369
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-369>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    words = list( args[ 0 ].lower().split() )
    tag   = '#'
    pattern = re.compile( '[a-zA-Z\-]+' )

    for w in words:
        if not pattern.match( w ):
            continue

        while '-' in w:
            w = w.replace( '-', '' )

        tag += w[ 0 ].upper() + w[ 1: ].lower()


    return tag


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
