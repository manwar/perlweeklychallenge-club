#!python

#
# Perl Weekly Challenge 353
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-353>
#

import sys
import re

# task implementation
# the return value will be printed
def task_2( args ):
    result  = []
    regex   = re.compile( r'\s+' )
    codes   = list( regex.split( args[0] ) )
    names   = list( regex.split( args[1] ) )
    status  = list( regex.split( args[2] ) )


    r1 = re.compile( r'^[a-zA-Z0-9_]+$' )
    r2 = re.compile( r'^electronics|grocery|pharmacy|restaurant$' )

    for i in range( 0, len( codes ) ):
        if r1.match( codes[ i ] ) and r2.match( names[ i ] ) and status[ i ] == "true":
            result.append( "true" )
        else:
            result.append( "false" )

    return result


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
