#!python

#
# Perl Weekly Challenge 347
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-347>
#

import sys


# task implementation
# the return value will be printed
def task_2( args ):
    phone = args[ 0 ].replace( '-', '' ).replace( ' ', '' )

    groups = []
    while len( phone ) > 0:
        if len( phone ) >= 3:
            groups.append( phone[ 0 : 3 ] )
            phone = phone[ 3: ]
        else:
            groups.append( phone )
            phone = ''

    if len( groups[ -1 ] ) != 2 and len( groups[ -1 ] ) != 3:
        begin = groups[ -2 ]
        end   = groups[ -1 ]
        last  = begin + end
        groups[ -2 ] = last[ 0 : 2 ]
        groups[ -1 ] = last[ 2 : 4 ]

    return '-'.join( groups )

# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
