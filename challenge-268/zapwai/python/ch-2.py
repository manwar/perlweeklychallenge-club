def proc(ints):
    new = []
    print("Input:", ints)
    ints.sort()
    while len(ints) > 0:
        x = ints.pop(0)
        y = ints.pop(0)
        new.append(y)
        new.append(x)
    print("Output:", new)

ints = [2, 5, 3, 4]
proc(ints)

