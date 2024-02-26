def proc(k, ints):
    print("Input: ints:", ints, "k:", k)
    sum = 0
    ind = []
    for i in range(len(ints)):
        tally = 0;
        s = format(f'{i:b}')
        for c in list(s):
            if c == "1":
                tally += 1
        if tally == k:
            ind.append(i)
    for i in ind:
        sum += ints[i]
    print("Output:",sum)
ints1 = [2, 5, 9, 11, 3]; k1 = 1
ints2 = [2, 5, 9, 11, 3]; k2 = 2
ints3 = [2, 5, 9, 11, 3]; k3 = 0

proc(k1, ints1)
proc(k2, ints2)
proc(k3, ints3)
