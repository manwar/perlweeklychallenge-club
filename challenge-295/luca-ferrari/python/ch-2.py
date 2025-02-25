#!python

#
# Perl Weekly Challenge 295
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-295>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    numbers = list( map( int, args ) )

    position = 0
    jumps = len( numbers ) + 2

    for index in range( 0, len( numbers ) - 2 ):
        position = index
        counter  = index


        while position < len( numbers ) - 1 :
            jump = numbers[ position ]
            if jump == 0:
                break

            position += jump
            counter += 1



        if counter < jumps and position == ( len( numbers ) - 1 ):
            jumps = counter

    if jumps < len( numbers ) - 1:
        return jumps
    else:
        return -1



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
