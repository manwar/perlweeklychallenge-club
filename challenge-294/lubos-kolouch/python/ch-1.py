def longest_consecutive_sequence(ints):

    nums = set(ints)  # Step 1: Create a set
    max_length = 0

    for num in ints:  # Step 2: Iterate over each number
        if num - 1 not in nums:
            current_num = num
            current_length = 1

            # Step 3: Expand the sequence
            while current_num + 1 in nums:
                current_num += 1
                current_length += 1

            # Step 4: Update the maximum length
            if current_length > max_length:
                max_length = current_length

    # Step 5: Return the result
    return max_length if max_length > 1 else -1


# Test cases
test_cases = [
    {
        'ints': [10, 4, 20, 1, 3, 2],
        'expected': 4
    },
    {
        'ints': [0, 6, 1, 8, 5, 2, 4, 3, 0, 7],
        'expected': 9
    },
    {
        'ints': [10, 30, 20],
        'expected': -1
    },
    {
        'ints': [1, 9, 3, 10, 4, 20, 2],
        'expected': 4
    },
    {
        'ints': [5, 6, 1, 2, 3, 4],
        'expected': 6
    },
    {
        'ints': [100, 4, 200, 1, 3, 2],
        'expected': 4
    },
]

for test in test_cases:
    result = longest_consecutive_sequence(test['ints'])
    print(f"Input: ints = {test['ints']}")
    print(f"Output: {result}")
    print(f"Expected: {test['expected']}")
    print("-" * 40)
