import os
import random
import unittest
from typing import List


def get_random_word() -> str:
    """
    Reads its own source code, splits it into words, and returns one word at random.

    Returns:
        str: A random word from the script's source code.
    """
    filename: str = os.path.abspath(__file__)
    with open(filename, 'r') as f:
        content: str = f.read()
    words: List[str] = content.split()
    random_word: str = random.choice(words)
    return random_word


def main() -> None:
    word: str = get_random_word()
    print(word)


if __name__ == "__main__":
    main()

    # Unit Test
    class TestSelfSpammer(unittest.TestCase):

        def test_word_in_source(self):
            word = get_random_word()
            filename = os.path.abspath(__file__)
            with open(filename, 'r') as f:
                content = f.read()
            self.assertIn(word, content.split(), "Word is from source code")

    unittest.main(argv=['first-arg-is-ignored'], exit=False)
