def proc(ints):
    print( "Input: ints =", ints)
    num = 0
    for i in range(len(ints)):
        found = False
        elem = ints[i]
        for j in range(len(ints)):
            if i == j:
                continue
            new_elem = ints[j]
            if elem == new_elem:
                found = True
        if not found:
            num = elem
            break
    print("Output:", num);
ints = [3, 3, 1]
proc(ints)
ints = [3, 2, 4, 2, 4]
proc(ints)
ints = [1]
proc(ints)
