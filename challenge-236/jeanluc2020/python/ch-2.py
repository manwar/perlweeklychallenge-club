#!/usr/bin/python3
#
# This is just me learning a bit of python.
# Look at the perl solution for a discussion of the details.

seen_index = {}

def get_loop(index, ints):
    loop = []
    index = ints[index]
    while not index in seen_index:
        seen_index[index] = 1
        loop.append(index)
        index = ints[index]
    return loop

def array_loops(*ints):
    loops = []
    seen_index.clear()
    for index in range(len(ints)):
        if index in seen_index:
            next
        loop = get_loop(index, ints)
        if len(loop) > 0:
            loops.append(loop)
    print("Output: ", len(loops))
    for loop in loops:
        print("[", end="")
        print(*loop, sep=", ", end="")
        print("]")

array_loops(4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)
array_loops(0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)
array_loops(9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
