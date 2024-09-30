#!python

#
# Perl Weekly Challenge 289
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-289>
#

import sys
import random

# task implementation
# the return value will be printed
def task_2( words ):
    new_words = []

    for word in words:
        current_word = []
        current_word.append( word[ 0 ] )

        last_index = len( word ) - 1
        while not str.isalpha( word[ last_index ] ) and not str.isdigit( word[ last_index ] ):
            last_index -= 1

        shuffling = list( map( str, word[ 1 : last_index ] ) )
        random.shuffle( shuffling )
        for r in shuffling:
            current_word.append( r )

        current_word.append( word[ last_index : ] )
        new_words.append( ''.join( current_word ) )

    return new_words



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
