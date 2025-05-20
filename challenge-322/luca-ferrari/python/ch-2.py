#!python

#
# Perl Weekly Challenge 322
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-322>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    numbers = list( map( int, args ) )
    sorted_numbers = list( map( int, args ) )
    sorted_numbers.sort()
    result = []

    for c in numbers:
        index = 1
        for x in sorted_numbers:
            if x == c:
                result.append( index )
            else:
                index += 1


    return result


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
