import sys

# task implementation
# the return value will be printed
def task_2( args ):
    nums = list( map( int, args ) )

    strong = []

    for i in range( 0, len( nums ) - 1 ):
        for j in range( i + 1, len( nums ) ):
            if nums[ i ] != nums[ j ] and abs( nums[ i ] - nums[ j ] ) < min( nums[ i ], nums[ j ] ):
               strong.append( str( nums[ i ] ) + "<->" + str( nums[ j ] ) )

    return len( strong )


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )

