def proc(ints):
    print("Input:", ints)
    nums = []
    freq = [1] * MAX_LENGTH
    for item in ints:
        have = 0
        for j in nums:
            if j == item:
                have += 1

        if have == 0:
            nums.append(item)
        else:
            freq[item] = have + 1
    print("Output:")
    for i in range(len(freq)):
        if freq[i] != 1:
            print(i, "->", freq[i])
    mostfreq = []
    f = 0
    for num in nums:
        if freq[num] > f:
            f = freq[num]
    for num in nums:
        if freq[num] == f:
            mostfreq.append(num)

    print("The most frequent is", mostfreq, "with", f, "occurrences.")


MAX_LENGTH = 20
ints = [1, 2, 2, 4, 1, 5]
proc(ints)
ints = [1, 2, 3, 4, 5]
proc(ints)

