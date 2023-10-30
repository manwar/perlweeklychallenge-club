#!/usr/bin/env python

def loopExistsAt(ints=[], seen={}, start=0):
    # bail early if we're in a loop we've seen before
    if start in seen:
        return []

    loop = [] # initialize an empty list to start
    i = start # initialize i to starting point
    while True:
        # keep track of the values in the order we visit them
        loop.append(ints[i])

        # track where we've already been
        # to avoid double-counting loops
        seen[i] = 1

        # get the next index
        i = ints[i]

        # make sure the index is in bounds
        if i < 0 or i >= len(ints):
            break

        # make sure we haven't seen the index before
        if i in seen:
            break

    # if the last element points back to
    # the start, it's a loop!
    if loop[-1] == start:
        return loop

    # otherwise, return an empty list
    return []

def identifyLoops(ints):
    loops = []
    seen = {}; # keep track of indices we've seen
               # to avoid duplicating loops
    for start in range(0, len(ints)):
        loop = loopExistsAt(
          start = start,
          ints  = ints,
          seen  = seen
        )
        if loop:
            loops.append(loop)
    return loops

def solution(ints):
    as_list = ','.join(map(lambda i: str(i), ints))
    print(f'Input: @ints = ({as_list})')
    loops = identifyLoops(ints)
    count = len(loops)
    print(f'Output: {count}')
    if count:
        loop_noun = "Loops" if count != 1 else "Loop"
        are_verb  = "are"   if count != 1 else "is"
        print(f'\n{loop_noun} {are_verb} as below:')
        for loop in loops:
            as_list = ' '.join(map(lambda i: str(i), loop))
            print(f'[{as_list}]')


print('Example 1:')
solution([4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10])

print('\nExample 2:')
solution([0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19])

print('\nExample 3:')
solution([9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17])
