from functools import cmp_to_key
import unittest


def alien_sort(words: list[str], alien_order: list[str]) -> list[str]:
    order = {char: idx for idx, char in enumerate(alien_order)}

    def compare(a: str, b: str) -> int:
        for ca, cb in zip(a, b):
            if ca != cb:
                return -1 if order[ca] < order[cb] else 1
        return len(a) - len(b)

    return sorted(words, key=cmp_to_key(compare))


class TestAlienSort(unittest.TestCase):

    def test_example1(self):
        words = ["perl", "python", "raku"]
        alien = [
            "h", "l", "a", "b", "y", "d", "e", "f", "g", "i", "r", "k", "m",
            "n", "o", "p", "q", "j", "s", "t", "u", "v", "w", "x", "c", "z"
        ]
        expected = ["raku", "python", "perl"]
        self.assertEqual(alien_sort(words, alien), expected)

    def test_example2(self):
        words = ["the", "weekly", "challenge"]
        alien = [
            "c", "o", "r", "l", "d", "a", "b", "t", "e", "f", "g", "h", "i",
            "j", "k", "m", "n", "p", "q", "s", "w", "u", "v", "x", "y", "z"
        ]
        expected = ["challenge", "the", "weekly"]
        self.assertEqual(alien_sort(words, alien), expected)

    def test_same_prefix(self):
        words = ["apple", "apples"]
        alien = list("abcdefghijklmnopqrstuvwxyz")
        expected = ["apple", "apples"]
        self.assertEqual(alien_sort(words, alien), expected)
        alien_reversed = list(reversed(alien))
        expected_reversed = ["apple", "apples"]  # Corrected expected result
        self.assertEqual(alien_sort(words, alien_reversed), expected_reversed)

    def test_empty_list(self):
        self.assertEqual(alien_sort([], []), [])


if __name__ == '__main__':
    unittest.main()
