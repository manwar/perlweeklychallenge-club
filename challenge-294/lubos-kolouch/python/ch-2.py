def next_permutation(ints):
    n = len(ints)
    # Step 1: Find the largest index i such that ints[i] < ints[i + 1]
    i = n - 2
    while i >= 0 and ints[i] >= ints[i + 1]:
        i -= 1

    if i < 0:
        # The given permutation is the last permutation
        # Return the first permutation (sorted array)
        return sorted(ints)

    # Step 2: Find the largest index j > i such that ints[i] < ints[j]
    j = n - 1
    while ints[j] <= ints[i]:
        j -= 1

    # Step 3: Swap ints[i] and ints[j]
    ints[i], ints[j] = ints[j], ints[i]

    # Step 4: Reverse the sub-array from ints[i + 1] to the end
    ints[i + 1:] = reversed(ints[i + 1:])

    return ints


# Test cases
test_cases = [
    {
        'ints': [1, 2, 3],
        'expected': [1, 3, 2]
    },
    {
        'ints': [2, 1, 3],
        'expected': [2, 3, 1]
    },
    {
        'ints': [3, 1, 2],
        'expected': [3, 2, 1]
    },
    {
        'ints': [3, 2, 1],
        'expected': [1, 2, 3]
    },  # Last permutation; returns first
    {
        'ints': [1, 1, 5],
        'expected': [1, 5, 1]
    },
    {
        'ints': [1, 5, 1],
        'expected': [5, 1, 1]
    },
]

for test in test_cases:
    ints_copy = test['ints'].copy()
    result = next_permutation(ints_copy)
    print(f"Input: ints = {test['ints']}")
    print(f"Output: {result}")
    print(f"Expected: {test['expected']}")
    print("-" * 40)
