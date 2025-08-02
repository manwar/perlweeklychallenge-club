def proc(ints):
    spec = []
    for i in range(len(ints)):
        if len(ints) % (i+1) == 0:
            spec.append(ints[i])
    sum = 0
    for v in spec:
        sum += v*v
    print("Input: ints =", ints)
    print(f"Output: {sum}")
ints = [1,2,3,4]
proc(ints)
ints = [2, 7, 1, 19, 18, 3]
proc(ints)
