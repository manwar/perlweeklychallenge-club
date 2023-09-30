#!/usr/bin/env python3


def array_loops(elements):
    ''' determine how many loops are in the given array
    >>> array_loops([4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10])
    3
    >>> array_loops([0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19])
    6
    >>> array_loops([9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17])
    1
    '''
    loops = []
    seen = []
    for index, value in enumerate(elements):
        if index in seen:
            continue
        start = index
        loop = []
        index = elements[index]
        while(start != index):
            loop.append(index)
            seen.append(index)
            index = elements[index]
        loop.append(start)
        seen.append(start)
        loops.append(loop)
    return len(loops)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
