def twice_largest_index(ints):
    if not ints:
        return -1

    max_value = max(ints)
    max_index = ints.index(max_value)

    for i, val in enumerate(ints):
        if i != max_index and max_value < 2 * val:
            return -1
    return max_index


# Test cases
test_cases = [
    [2, 4, 1, 0],  # Expected output: 1
    [1, 2, 3, 4],  # Expected output: -1
    [5, 1, 2, 3],  # Expected output: 0
    [1],  # Expected output: 0
    [0, 0, 0, 1],  # Expected output: 3
]

for test in test_cases:
    result = twice_largest_index(test)
    print(f"Input: ints = {test}")
    print(f"Output: {result}\n")
