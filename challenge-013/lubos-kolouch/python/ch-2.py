#!/usr/bin/env python3
"""
Challenge 013, Task 2: Mutually Recursive Methods (Hofstadter sequences)

Demonstrate mutually recursive methods by generating the Hofstadter
Female and Male sequences.

The sequences are defined as:
    F(0) = 1,  M(0) = 0
    F(n) = n - M(F(n-1)),  n > 0
    M(n) = n - F(M(n-1)),  n > 0

Author: Lubos Kolouch
"""

import unittest


# Cache for memoization
_f_cache: dict[int, int] = {0: 1}
_m_cache: dict[int, int] = {0: 0}


def female(n: int) -> int:
    """
    Calculate the nth element of the Hofstadter Female sequence.

    The sequence is defined as:
        F(0) = 1
        F(n) = n - M(F(n-1)), for n > 0

    Args:
        n: The index (non-negative integer)

    Returns:
        The nth element of the Female sequence

    Examples:
        >>> [female(i) for i in range(10)]
        [1, 1, 2, 2, 3, 3, 4, 5, 5, 6]
    """
    if n in _f_cache:
        return _f_cache[n]

    result = n - male(female(n - 1))
    _f_cache[n] = result
    return result


def male(n: int) -> int:
    """
    Calculate the nth element of the Hofstadter Male sequence.

    The sequence is defined as:
        M(0) = 0
        M(n) = n - F(M(n-1)), for n > 0

    Args:
        n: The index (non-negative integer)

    Returns:
        The nth element of the Male sequence

    Examples:
        >>> [male(i) for i in range(10)]
        [0, 0, 1, 2, 2, 3, 4, 4, 5, 6]
    """
    if n in _m_cache:
        return _m_cache[n]

    result = n - female(male(n - 1))
    _m_cache[n] = result
    return result


def get_sequences(n: int) -> tuple[list[int], list[int]]:
    """
    Get the first n elements of both Hofstadter sequences.

    Args:
        n: Number of elements to generate

    Returns:
        Tuple of (Female sequence, Male sequence) lists

    Examples:
        >>> f, m = get_sequences(10)
        >>> f
        [1, 1, 2, 2, 3, 3, 4, 5, 5, 6]
        >>> m
        [0, 0, 1, 2, 2, 3, 4, 4, 5, 6]
    """
    female_seq = [female(i) for i in range(n)]
    male_seq = [male(i) for i in range(n)]
    return female_seq, male_seq


def main() -> None:
    """Main function to display the sequences."""
    n = 10
    female_seq, male_seq = get_sequences(n)

    print("Hofstadter Female sequence:")
    print(", ".join(map(str, female_seq)))

    print("\nHofstadter Male sequence:")
    print(", ".join(map(str, male_seq)))


if __name__ == "__main__":
    main()


class TestHofstadterSequences(unittest.TestCase):
    """Unit tests for Hofstadter Female and Male sequences."""

    def test_female_sequence_base(self):
        """Test F(0) = 1."""
        self.assertEqual(female(0), 1)

    def test_male_sequence_base(self):
        """Test M(0) = 0."""
        self.assertEqual(male(0), 0)

    def test_female_sequence_first_ten(self):
        """Test first 10 elements of Female sequence."""
        expected = [1, 1, 2, 2, 3, 3, 4, 5, 5, 6]
        self.assertEqual([female(i) for i in range(10)], expected)

    def test_male_sequence_first_ten(self):
        """Test first 10 elements of Male sequence."""
        expected = [0, 0, 1, 2, 2, 3, 4, 4, 5, 6]
        self.assertEqual([male(i) for i in range(10)], expected)

    def test_get_sequences(self):
        """Test get_sequences function."""
        female_seq, male_seq = get_sequences(10)
        self.assertEqual(female_seq, [1, 1, 2, 2, 3, 3, 4, 5, 5, 6])
        self.assertEqual(male_seq, [0, 0, 1, 2, 2, 3, 4, 4, 5, 6])

    def test_female_sequence_specific_values(self):
        """Test specific values of Female sequence."""
        # F(0) = 1
        self.assertEqual(female(0), 1)
        # F(1) = 1 - M(F(0)) = 1 - M(1) = 1 - 0 = 1
        self.assertEqual(female(1), 1)
        # F(2) = 2 - M(F(1)) = 2 - M(1) = 2 - 0 = 2
        self.assertEqual(female(2), 2)
        # F(3) = 3 - M(F(2)) = 3 - M(2) = 3 - 1 = 2
        self.assertEqual(female(3), 2)

    def test_male_sequence_specific_values(self):
        """Test specific values of Male sequence."""
        # M(0) = 0
        self.assertEqual(male(0), 0)
        # M(1) = 1 - F(M(0)) = 1 - F(0) = 1 - 1 = 0
        self.assertEqual(male(1), 0)
        # M(2) = 2 - F(M(1)) = 2 - F(0) = 2 - 1 = 1
        self.assertEqual(male(2), 1)
        # M(3) = 3 - F(M(2)) = 3 - F(1) = 3 - 1 = 2
        self.assertEqual(male(3), 2)

    def test_mutual_recursion(self):
        """Test that the functions are truly mutually recursive."""
        # This tests the mutual recursion by checking values that
        # require both functions to be called in an interleaved manner
        for i in range(20):
            f_val = female(i)
            m_val = male(i)
            self.assertIsInstance(f_val, int)
            self.assertIsInstance(m_val, int)
            self.assertGreaterEqual(f_val, 0)
            self.assertGreaterEqual(m_val, 0)


if __name__ == "__main__":
    unittest.main()
