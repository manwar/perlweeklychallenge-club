import unittest
from collections import Counter


def equal_pairs(ints):
    freq = Counter(ints)
    seen = set()
    ordered_elements = []

    # Keep the order of first occurrence
    for num in ints:
        if num not in seen:
            seen.add(num)
            ordered_elements.append(num)

    # Check if all elements have even frequency
    if any(count % 2 for count in freq.values()):
        return []

    # Form pairs in the order of first occurrence
    pairs = []
    for num in ordered_elements:
        pairs.extend([[num, num] for _ in range(freq[num] // 2)])

    return pairs


# Unit tests
class TestEqualPairs(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(equal_pairs([3, 2, 3, 2, 2, 2]), [[3, 3], [2, 2], [2, 2]])

    def test_example_2(self):
        self.assertEqual(equal_pairs([1, 2, 3, 4]), [])


if __name__ == "__main__":
    unittest.main()
