def proc(ints):
    print("Input: ints =", ints)
    sum = 0
    while (ints):
        a = ints[0]
        if len(ints) == 1:
            sum += a
            break
        ints = ints[1:]
        b = ints.pop()
        sum += int(str(a)+str(b))
    print("Output:", sum)
ints = [6, 12, 25, 1]
proc(ints)
ints = [10, 7, 31, 5, 2, 2]
proc(ints)
ints = [1, 2, 10]
proc(ints)
