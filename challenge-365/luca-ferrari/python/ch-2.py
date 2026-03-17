#!python

#
# Perl Weekly Challenge 365
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-365>
#

import sys
import re

# task implementation
# the return value will be printed
def task_2( args ):
    sentence = args[ 0 ]

    counter = 0

    for word in sentence.split( ' ' ):
        if re.search( r'\d+', word ) or re.search( r'[A-Z]-', word ) or re.search( r'-[A-Z]', word ) or re.search(  r'[!.,].+', word ):
            continue
        counter += 1

    return counter



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
