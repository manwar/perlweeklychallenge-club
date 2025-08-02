from collections import Counter
from typing import List


def shortest_completing_word(target: str, words: List[str]) -> str:
    # Function to clean and count the letters in a word
    def get_letter_counts(s: str) -> Counter:
        return Counter(c.lower() for c in s if c.isalpha())

    target_count = get_letter_counts(target)

    # Filter and find the shortest completing word
    valid_words = [word for word in words if not target_count - get_letter_counts(word)]
    return min(valid_words, key=len) if valid_words else ""


# Test cases
assert shortest_completing_word("aBc 11c", ["accbbb", "abc", "abbc"]) == "accbbb"
assert shortest_completing_word("Da2 abc", ["abcm", "baacd", "abaadc"]) == "baacd"
assert shortest_completing_word("JB 007", ["jj", "bb", "bjb"]) == "bjb"
