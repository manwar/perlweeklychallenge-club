def proc(ints):
    index = -1
    for i in range(len(ints)):
        if i % 10 == ints[i]:
            index = i
            break
    print("Input: ", ints)
    print("Output: ", index)

ints = [0, 1, 2]
proc(ints)

ints = [4,3,2,1]
proc(ints)

ints = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
proc(ints)
