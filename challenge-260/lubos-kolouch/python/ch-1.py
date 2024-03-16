from typing import List


def unique_occurrences(ints: list[int]) -> int:
    """
    Checks if the number of occurrences of each value
    in the given array is unique.

    Parameters:
    - ints (List[int]): A list of integers.

    Returns:
    - int: 1 if all occurrences are unique, 0 otherwise.
    """
    # Count the occurrences of each integer
    occurrence_counts: dict[int, int] = {}
    for num in ints:
        if num in occurrence_counts:
            occurrence_counts[num] += 1
        else:
            occurrence_counts[num] = 1

    # Check if all occurrence counts are unique
    counts = list(occurrence_counts.values())
    return 1 if len(counts) == len(set(counts)) else 0


# Test cases
def test_unique_occurrences():
    assert unique_occurrences([1, 2, 2, 1, 1, 3]) == 1
    assert unique_occurrences([1, 2, 3]) == 0
    assert unique_occurrences([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]) == 1


# Run tests
test_unique_occurrences()
