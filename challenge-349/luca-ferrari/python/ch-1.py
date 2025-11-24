#!python

#
# Perl Weekly Challenge 349
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-349>
#

import sys

# task implementation
# the return value will be printed
def task_1( args ):
    string = args[ 0 ]
    previous = ''
    result   = 0
    count    = 0

    for current in string :
        if previous is None or previous != current :
            if count > result :
                result = count

            count = 0
            previous = current

        count += 1

    if count > result :
        result = count

    return result



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
