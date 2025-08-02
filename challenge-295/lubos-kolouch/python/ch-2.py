def min_jumps(ints):
    n = len(ints)
    # Edge cases
    if n <= 1:
        return 0
    if ints[0] == 0:
        return -1

    jumps = 0
    current_end = 0
    farthest = 0

    for i in range(n - 1):
        farthest = max(farthest, i + ints[i])

        # If we have reached the end of what the last jump could reach
        if i == current_end:
            jumps += 1
            current_end = farthest

            # If current_end is beyond or at the last index, we can reach the end
            if current_end >= n - 1:
                return jumps

        # If the farthest we can reach is less than or equal to the current index
        if farthest <= i:
            return -1

    return -1


# Test cases
test_cases = [
    {
        'ints': [2, 3, 1, 1, 4],
        'expected': 2
    },
    {
        'ints': [2, 3, 0, 4],
        'expected': 2
    },
    {
        'ints': [2, 0, 0, 4],
        'expected': -1
    },
    {
        'ints': [1, 1, 1, 1],
        'expected': 3
    },
    {
        'ints': [0],
        'expected': 0
    },
    {
        'ints': [1, 0, 1, 0],
        'expected': -1
    },
    {
        'ints': [2, 1],
        'expected': 1
    },
    {
        'ints': [1, 2, 3],
        'expected': 2
    },
]

for test in test_cases:
    result = min_jumps(test['ints'])
    print(f"Input: ints = {test['ints']}")
    print(f"Output: {result}")
    print(f"Expected: {test['expected']}")
    print("-" * 40)
