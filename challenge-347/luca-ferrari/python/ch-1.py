#!python

#
# Perl Weekly Challenge 347
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-347>
#

import sys
import re

# task implementation
# the return value will be printed
def task_1( args ):
    months = { 'Jan' : 1,
               'Feb' : 2,
               'Mar' : 3,
               'Apr' : 4,
               'May' : 5,
               'Jun' : 6,
               'Jul' : 7,
               'Aug' : 8,
               'Sep' : 9,
               'Oct' : 10,
               'Nov' : 11,
               'Dec' : 12 }


    r = re.compile( r'\s+' )
    parts = r.split( args[ 0 ] )

    return '-'.join( [ parts[ 2 ],
                       str( months[ parts[ 1 ] ] ),
                       parts[ 0 ].replace( 'st', '' ).replace( 'nd', '' ).replace( 'rd', '' ).replace( 'th', '' ) ] )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )
