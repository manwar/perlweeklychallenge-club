def proc(k, ints) :
    print("Input:", ints)
    ints.sort()
    ind = []
    for i in range(len(ints)):
        if ints[i] == k:
            ind.append(i)
    print("Output:", ind)

ints1 = [1, 5, 3, 2, 4, 2]; k1 = 2
ints2 = [1, 2, 4, 3, 5]; k2 = 6
ints3 = [5, 3, 2, 4, 2, 1]; k3 = 4
proc(k1, ints1)
proc(k2, ints2)
proc(k3, ints3)
