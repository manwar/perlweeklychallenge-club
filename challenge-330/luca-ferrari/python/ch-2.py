#!python

#
# Perl Weekly Challenge 330
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-330>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    parts = []

    for current in args :
        if len( current ) >= 3 :
            current = current.title()
        else:
            current = current.lower()

        parts.append( current )

    return ' '.join( parts )



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
