ints = [3, 1, 2, 2, 2, 1, 3]
k = 2
print("Input: ints:", ints, "k:", k)
cnt = 0
for i in range(len(ints) - 1):
    for j in range(i + 1, len(ints)):
        if ints[i] != ints[j]:
            continue
        if i * j % k == 0:
            cnt += 1
print("Output:", cnt)
