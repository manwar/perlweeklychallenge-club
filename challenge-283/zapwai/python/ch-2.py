def proc(ints):
    print("Input: ints =", ints)
    veracity = True
    for i in range(len(ints)):
        freq = ints[i]
        cnt = 0
        for elem in ints:
            if elem == i:
                cnt += 1 
        if cnt != freq:
            veracity = False
            break
    print("Output:", veracity)
ints = [1, 2, 1, 0]
proc(ints)
ints = [0, 3, 0]
proc(ints)
