def proc(ints):
    print("Input: ints =", ints)
    lucky = -1
    freq = []
    for j in range(1 + max(ints)):
        freq.append(0)
    for item in ints:
        freq[item] += 1
    
    for i in range(1, len(freq)):
        if i == freq[i]:
            lucky = i
    print("Output:", lucky)

ints = [2, 2, 3, 4]
proc(ints)
ints = [1, 2, 2, 3, 3, 3]
proc(ints)
ints = [1, 1, 1, 3]
proc(ints)
