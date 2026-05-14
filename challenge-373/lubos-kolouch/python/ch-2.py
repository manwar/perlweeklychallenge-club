#!/usr/bin/env python3
"""Solution for Perl Weekly Challenge 373 Task 2: List Division"""


def divide_list(lst, n):
    """Divide list into n equal parts, distributing remainder from front.

    Returns -1 if n > len(lst).
    """
    size = len(lst)
    if n > size:
        return -1

    base_size = size // n
    remainder = size % n

    result = []
    start = 0

    for i in range(n):
        # Add 1 to chunk size for first 'remainder' chunks
        chunk_size = base_size + (1 if i < remainder else 0)
        end = start + chunk_size
        result.append(lst[start:end])
        start = end

    return result


# Test cases
if __name__ == "__main__":
    test_cases = [
        ([1, 2, 3, 4, 5], 2, [[1, 2, 3], [4, 5]]),
        ([1, 2, 3, 4, 5, 6], 3, [[1, 2], [3, 4], [5, 6]]),
        ([1, 2, 3], 2, [[1, 2], [3]]),
        ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5, [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]]),
        ([1, 2, 3], 4, -1),
        (
            [72, 57, 89, 55, 36, 84, 10, 95, 99, 35],
            7,
            [[72, 57], [89, 55], [36, 84], [10], [95], [99], [35]],
        ),
    ]

    for i, (lst, n, expected) in enumerate(test_cases, 1):
        result = divide_list(lst, n)
        status = "OK" if result == expected else "FAILED"
        print(f"Test {i}: {status}")
