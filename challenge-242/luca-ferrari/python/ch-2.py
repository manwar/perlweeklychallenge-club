#!python

#
# Perl Weekly Challenge 242
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-242/>
#
# $ python3 ch-2.py 1 0 0 '|' 0 0 1 '|' 1 1 1
# 1,1,0
# 0,1,1
# 0,0,0


import sys



# task implementation
def main( argv ):
    matrix = []
    current_row = 0

    matrix.append( [] )
    for current in argv:
        if current != '|':
            matrix[ current_row ].append( int( current ) )
        else:
            current_row += 1
            matrix.append( [] )

    # inner function to use with map
    # returns a string to make join happy!
    def task2(n):
        if n == 1:
            return "0"
        else:
            return "1"


    for current_row in matrix:
        print( ",".join( map( task2, reversed( current_row ) ) ) )




# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


