#!python

#
# Perl Weekly Challenge 295
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-295>
#

import sys


# task implementation
# the return value will be printed
def task_1( args ):
    sentence = args[ 0 ]
    words    = args[ 1: ]

    for word in words:
        if not word in sentence:
            return False

        sentence = sentence.replace( word, '' )

    return len( sentence ) == 0


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
