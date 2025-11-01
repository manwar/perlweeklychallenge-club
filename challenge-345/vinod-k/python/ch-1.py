def find_peaks(ints):
    peaks = []
    for i in range(len(ints)):
        left = float('-inf') if i == 0 else ints[i-1]
        right = float('-inf') if i == len(ints)-1 else ints[i+1]
        if ints[i] > left and ints[i] > right:
            peaks.append(i)
    return peaks

examples = [
    [1, 3, 2],
    [2, 4, 6, 5, 3],
    [1, 2, 3, 2, 4, 1],
    [5, 3, 1],
    [1, 5, 1, 5, 1, 5, 1],
]

for ex in examples:
    print(f"Input: {ex}")
    print(f"Output: {find_peaks(ex)}\n")
