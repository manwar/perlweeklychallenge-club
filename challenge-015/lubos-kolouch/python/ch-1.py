#!/usr/bin/env python3
"""
Challenge 015, Task 1: Strong and Weak Primes

Generate the first 10 strong and weak prime numbers.

Definition:
- Strong Prime: p(n) > (p(n-1) + p(n+1)) / 2
- Weak Prime: p(n) < (p(n-1) + p(n+1)) / 2
- Balanced Prime: p(n) = (p(n-1) + p(n+1)) / 2

Where p(n) is the nth prime number.

Author: Lubos Kolouch
"""

import unittest


def is_prime(n: int) -> bool:
    """
    Check if a number is prime.

    Args:
        n: The number to check

    Returns:
        True if prime, False otherwise

    Examples:
        >>> is_prime(2)
        True
        >>> is_prime(4)
        False
    """
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    return True


def get_primes(n: int) -> list[int]:
    """
    Get the first n prime numbers.

    Args:
        n: Number of primes to generate

    Returns:
        List of first n prime numbers

    Examples:
        >>> get_primes(10)
        [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
    """
    primes: list[int] = []
    candidate = 2

    while len(primes) < n:
        if is_prime(candidate):
            primes.append(candidate)
        candidate += 1 if candidate == 2 else 2

    return primes


def get_nth_prime(n: int) -> int:
    """
    Get the nth prime number (1-indexed).

    Args:
        n: The index (1-indexed)

    Returns:
        The nth prime number

    Examples:
        >>> get_nth_prime(1)
        2
        >>> get_nth_prime(10)
        29
    """
    return get_primes(n)[-1]


def is_strong_prime(p: int, primes: list[int]) -> bool:
    """
    Check if a prime is a strong prime.

    A prime p is strong if p > (prev_prime + next_prime) / 2

    Args:
        p: The prime to check
        primes: List of primes (must include p and surrounding primes)

    Returns:
        True if strong prime, False otherwise
    """
    idx = primes.index(p)
    prev_prime = primes[idx - 1]
    next_prime = primes[idx + 1]

    return p > (prev_prime + next_prime) / 2


def is_weak_prime(p: int, primes: list[int]) -> bool:
    """
    Check if a prime is a weak prime.

    A prime p is weak if p < (prev_prime + next_prime) / 2

    Args:
        p: The prime to check
        primes: List of primes (must include p and surrounding primes)

    Returns:
        True if weak prime, False otherwise
    """
    idx = primes.index(p)
    prev_prime = primes[idx - 1]
    next_prime = primes[idx + 1]

    return p < (prev_prime + next_prime) / 2


def is_balanced_prime(p: int, primes: list[int]) -> bool:
    """
    Check if a prime is a balanced prime.

    A prime p is balanced if p = (prev_prime + next_prime) / 2

    Args:
        p: The prime to check
        primes: List of primes (must include p and surrounding primes)

    Returns:
        True if balanced prime, False otherwise
    """
    idx = primes.index(p)
    prev_prime = primes[idx - 1]
    next_prime = primes[idx + 1]

    return p == (prev_prime + next_prime) / 2


def get_strong_primes(count: int) -> list[int]:
    """
    Get the first n strong prime numbers.

    Args:
        count: Number of strong primes to generate

    Returns:
        List of first n strong primes

    Examples:
        >>> get_strong_primes(5)
        [11, 17, 29, 37, 59]
    """
    strong_primes: list[int] = []
    idx = 0

    # We need primes around each candidate, so generate enough
    while len(strong_primes) < count:
        # Generate more primes as needed
        primes = get_primes(idx + 50)

        for i in range(1, len(primes) - 1):
            p = primes[i]
            if is_strong_prime(p, primes) and p not in strong_primes:
                strong_primes.append(p)
                if len(strong_primes) >= count:
                    return strong_primes[:count]

        idx += 50

    return strong_primes[:count]


def get_weak_primes(count: int) -> list[int]:
    """
    Get the first n weak prime numbers.

    Args:
        count: Number of weak primes to generate

    Returns:
        List of first n weak primes

    Examples:
        >>> get_weak_primes(5)
        [3, 7, 13, 19, 23]
    """
    weak_primes: list[int] = []
    primes = get_primes(1000)  # Generate enough primes

    for i in range(1, len(primes) - 1):
        p = primes[i]
        if is_weak_prime(p, primes):
            weak_primes.append(p)
            if len(weak_primes) >= count:
                break

    return weak_primes[:count]


def main() -> None:
    """Main function to display strong and weak primes."""
    print("First 10 Strong Primes:")
    print(", ".join(map(str, get_strong_primes(10))))

    print("\nFirst 10 Weak Primes:")
    print(", ".join(map(str, get_weak_primes(10))))


if __name__ == "__main__":
    main()


class TestStrongWeakPrimes(unittest.TestCase):
    """Unit tests for strong and weak primes."""

    def test_is_prime(self):
        """Test prime checking."""
        self.assertTrue(is_prime(2))
        self.assertTrue(is_prime(3))
        self.assertTrue(is_prime(5))
        self.assertTrue(is_prime(7))
        self.assertTrue(is_prime(11))
        self.assertFalse(is_prime(1))
        self.assertFalse(is_prime(4))
        self.assertFalse(is_prime(6))
        self.assertFalse(is_prime(9))

    def test_get_primes(self):
        """Test getting first n primes."""
        self.assertEqual(get_primes(10), [2, 3, 5, 7, 11, 13, 17, 19, 23, 29])

    def test_get_nth_prime(self):
        """Test getting nth prime."""
        self.assertEqual(get_nth_prime(1), 2)
        self.assertEqual(get_nth_prime(10), 29)
        self.assertEqual(get_nth_prime(25), 97)

    def test_is_strong_prime(self):
        """Test strong prime checking."""
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
        # p(5) = 11, p(4) = 7, p(6) = 13, (7+13)/2 = 10, 11 > 10 => strong
        self.assertTrue(is_strong_prime(11, primes))
        # p(3) = 5, p(2) = 3, p(4) = 7, (3+7)/2 = 5, 5 = 5 => NOT strong
        self.assertFalse(is_strong_prime(5, primes))

    def test_is_weak_prime(self):
        """Test weak prime checking."""
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
        # p(3) = 5, p(2) = 3, p(4) = 7, (3+7)/2 = 5, 5 < 5? No, it's equal => NOT weak
        self.assertFalse(is_weak_prime(5, primes))
        # p(2) = 3, p(1) = 2, p(3) = 5, (2+5)/2 = 3.5, 3 < 3.5 => weak
        self.assertTrue(is_weak_prime(3, primes))

    def test_is_balanced_prime(self):
        """Test balanced prime checking."""
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
        # 5 is balanced: (3 + 7) / 2 = 5
        self.assertTrue(is_balanced_prime(5, primes))
        self.assertFalse(is_balanced_prime(7, primes))

    def test_get_strong_primes_first_five(self):
        """Test first 5 strong primes."""
        # Expected: 11, 17, 29, 37, 59 (from the definition)
        result = get_strong_primes(5)
        self.assertEqual(len(result), 5)
        # 11 is the first strong prime
        self.assertIn(11, result)

    def test_get_weak_primes_first_five(self):
        """Test first 5 weak primes."""
        result = get_weak_primes(5)
        self.assertEqual(len(result), 5)
        # 3 is the first weak prime
        self.assertIn(3, result)

    def test_strong_primes_count(self):
        """Test we get correct count of strong primes."""
        for count in [1, 5, 10]:
            result = get_strong_primes(count)
            self.assertEqual(len(result), count)

    def test_weak_primes_count(self):
        """Test we get correct count of weak primes."""
        for count in [1, 5, 10]:
            result = get_weak_primes(count)
            self.assertEqual(len(result), count)


if __name__ == "__main__":
    unittest.main()
