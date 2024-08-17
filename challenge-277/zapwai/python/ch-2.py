def proc(ints):
    print("Input:", ints )
    cnt = 0
    for i in range(len(ints) - 1):
        for j in range(i + 1, len(ints)):
            if ints[i] != ints[j] and abs(ints[i] - ints[j]) < min(ints[i], ints[j]):
                cnt += 1 
    print("Output:", cnt)

ints = [1, 2, 3, 4, 5]
proc(ints)
ints = [5, 7, 1, 7]
proc(ints)
