#!python

#
# Perl Weekly Challenge 239
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-239/>
#

import sys

# task implementation
def main( argv ):
    words1 = argv[ 1 : int( argv[ 0 ] ) + 1 ]
    words2 = argv[ int( argv[ 0 ] ) + 2 : ]

    if ''.join( words1 ) == ''.join( words2 ):
        print( "true" )
    else:
        print( "false" )




# invoke the main without the command itself
# $ python3 ch-1.py 2 'ab' 'c' 2 'a' 'bc'
# true
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


