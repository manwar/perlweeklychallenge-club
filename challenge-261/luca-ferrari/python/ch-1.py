#!python

#
# Perl Weekly Challenge 261
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-261>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    sum_numbers = sum( list( map( int, args ) ) )
    sum_digits  = 0
    for num in args:
        for d in num:
            sum_digits += int( d )

    result = sum_numbers - sum_digits
    if result < 0:
        return result * -1

    return result


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
