def ulam_sequence(u, v, n=10):
    sequence = [u, v]
    while len(sequence) < n:
        sums = {
            sequence[i] + sequence[j]: 0
            for i in range(len(sequence))
            for j in range(i + 1, len(sequence))
        }
        for i in range(len(sequence)):
            for j in range(i + 1, len(sequence)):
                sums[sequence[i] + sequence[j]] += 1
        next_val = min(x for x in sums if sums[x] == 1 and x > sequence[-1])
        sequence.append(next_val)
    return sequence


print(ulam_sequence(1, 2))
print(ulam_sequence(2, 3))
print(ulam_sequence(2, 5))
