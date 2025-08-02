from functools import reduce
from math import factorial
from operator import mul
from typing import Dict


def calculate_factorials(n: int) -> dict[int, int]:
    """Calculate factorials from 0 to n."""
    factorials = {0: 1}
    for i in range(1, n + 1):
        factorials[i] = factorials[i - 1] * i
    return factorials


def count_char_occurrences(word: str) -> dict[str, int]:
    """Count occurrences of each character in a word."""
    counts: dict[str, int] = {}
    for char in word:
        counts[char] = counts.get(char, 0) + 1
    return counts


def product(iterable):
    """Compute the product of an iterable of numbers."""
    return reduce(mul, iterable, 1)


def dictionary_rank(word: str) -> int:
    """Compute the dictionary rank of the given word."""
    length = len(word)
    factorials = calculate_factorials(length)
    char_counts = count_char_occurrences(word)
    rank = 1

    for i, char in enumerate(word):
        smaller_chars = sum(count for c, count in char_counts.items() if c < char)
        rank += (
            smaller_chars
            * factorials[length - i - 1]
            // product(factorials[c] for c in char_counts.values())
        )

        # Decrement the count for the current character
        char_counts[char] -= 1
        if char_counts[char] == 0:
            del char_counts[char]

    return rank


# Test cases
assert dictionary_rank("CAT") == 3
assert dictionary_rank("GOOGLE") == 88
assert dictionary_rank("SECRET") == 255
