import sys

# task implementation
# the return value will be printed
def task_1( args ):
    words1 = []
    words2 = []
    first  = True
    for w in args:
        if w == '|':
            first = False
        if first:
            words1.append( w )
        else:
            words2.append( w )

    single1 = []
    single2 = []
    for w in words1:
        if len( list( filter( lambda x: x == w, words1 ) ) ) == 1:
            if not w in single1:
                single1.append( w )

    for w in words2:
        if len( list( filter( lambda x: x == w, words2 ) ) ) == 1:
            if not w in single2:
                single2.append( w )

    counting = 0
    for w in single1:
        if w in single2:
            counting += 1

    return counting


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_1( sys.argv[ 1: ] ) )


