#!python

import sys
import collections

def reduce( n ):
    if n <= 9:
        return n

    multiplication = 1
    for digit in map( int, str( n ) ):
        multiplication *= digit

    return multiplication


def main( argv ):
    steps = {}
    for n in map( int, argv ):
        current_step = 0
        if n > 9:
            # need reduction
            current_value = n
            while current_value > 9:
                current_value = reduce( current_value )
                current_step += 1

        # if the key is not here, create a list
        if not str( current_step )  in steps:
            steps[ str( current_step ) ] = []

        steps[ str(current_step) ].append( n )

    # now traverse the dictionary and sort the array
    # and print it
    for k, v in collections.OrderedDict(sorted(steps.items())).items():
        print( ", ".join( map( str, v ) ) )



if __name__ == '__main__':
    main( sys.argv[ 1: ] )
