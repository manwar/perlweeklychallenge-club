def process_ints(ints):
    seen = []
    ans = []
    i = 0
    while i < len(ints):
        if ints[i] == -1:
            x = 0
            j = i - 1
            while j >= 0 and ints[j] == -1:
                x += 1
                j -= 1
            if x < len(seen):
                ans.append(seen[x])
            else:
                ans.append(-1)
        else:
            seen.insert(0, ints[i])
        i += 1
    return ans

examples = [
    [5, -1, -1],            # Output: [5, -1]
    [3, 7, -1, -1, -1],     # Output: [7, 3, -1]
    [2, -1, 4, -1, -1],     # Output: [2, 4, 2]
    [10, 20, -1, 30, -1, -1], # Output: [20, 30, 20]
    [-1, -1, 5, -1],        # Output: [-1, -1, 5]
]

for ex in examples:
    print(f"Input: {ex}")
    print(f"Output: {process_ints(ex)}\n")
