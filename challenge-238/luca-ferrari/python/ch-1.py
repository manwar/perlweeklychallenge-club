#!python

import sys

def main( argv ):
    running_sum = []
    current_index = 0
    while current_index < len( argv ):
        running_sum.insert( current_index, 0 )

        for n in argv[ 0 : current_index   ]:
            running_sum[ current_index ] += int( n )

        current_index += 1

    print( ", ".join( map( str, running_sum ) ) )




if __name__ == '__main__':
    main( sys.argv[ 1: ] )
