def count_similar_dominos(dominos):
    domino_counts = {}
    count = 0

    # Normalize dominos and count occurrences
    for domino in dominos:
        a, b = domino
        key = tuple(sorted((a, b)))
        domino_counts[key] = domino_counts.get(key, 0) + 1

    # Identify dominos that are similar to any other
    for domino in dominos:
        a, b = domino
        key = tuple(sorted((a, b)))
        if domino_counts[key] > 1:
            count += 1

    return count


# Test cases
test_cases = [
    {"dominos": [[1, 3], [3, 1], [2, 4], [6, 8]], "expected": 2},
    {"dominos": [[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]], "expected": 3},
]

for test in test_cases:
    result = count_similar_dominos(test["dominos"])
    print(f"Input: dominos = {test['dominos']}")
    print(f"Output: {result}")
    print(f"Expected: {test['expected']}")
    print("-" * 40)
