#!python

#
# Perl Weekly Challenge 312
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-312>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    boxes = {}
    data  = args[ 0 ]

    while len( data ) > 0 :
        color, box, data = data[ 0 ], data[ 1 ], data[ 2: ]
        if not box in boxes :
            boxes[ box ] = []

        boxes[ box ].append( color )

    found = 0
    for box in boxes :
        if "R" in boxes[ box ] and "G" in boxes[ box ] and "B" in boxes[ box ]:
            found += 1

    return found



# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
