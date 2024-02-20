#!python

#
# Perl Weekly Challenge 254
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-254>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    word = args[ 0 ].lower()
    vowels =  list( reversed( list( filter( lambda x: x in ('a','e','i','o','u'), word ) ) ) )
    output = ''
    for letter in word:
        if letter not in ( 'a', 'e', 'i', 'o', 'u' ) or len( vowels ) == 0
            output += letter
        else:
            output += vowels.pop( 0 )

    return output


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
