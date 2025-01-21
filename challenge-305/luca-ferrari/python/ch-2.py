#!python

#
# Perl Weekly Challenge 306
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-306>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    dictionary = args[ 0 ].lower()
    words = args[ 1 : ]

    sorted_words = []

    for x in dictionary:
        for w in words:
            if w.lower()[ 0 ] == x:
                sorted_words.append( w )

    return sorted_words


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
