#!python

#
# Perl Weekly Challenge 329
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-329>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    string = args[ 0 ]

    begin = 0
    end   = 0

    for i in range( 0, len( string ) - 1 ) :
        current = string[ i ]
        needle = current.upper()
        if current.isupper() :
            needle = current.lower()

        for j in range( i + 1, len( string ) ) :
            print( " => ", string[ j ] )
            if string[ j ] == needle :
                if ( end - begin ) < ( j - i ) :
                    begin = i
                    end   = j

    return string[ begin : end + 1 ]


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
