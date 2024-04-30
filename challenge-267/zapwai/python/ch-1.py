def sign_of_prod(ints):
    num_of_negs = 0
    for i in ints:
        if i < 0:
            num_of_negs += 1
        elif i == 0:
            return 0
    if num_of_negs % 2 == 0:
        return 1
    else:
        return -1

def proc(ints):
    print("Input: ints = ", ints)
    print("Output: ", sign_of_prod(ints))

ints = [-1, -2, -3, -4, 3, 2, 1]
proc(ints)
ints = [1, 2, 0, -2, -1]
proc(ints)
ints = [-1, -1, 1, -1, 2]
proc(ints)

