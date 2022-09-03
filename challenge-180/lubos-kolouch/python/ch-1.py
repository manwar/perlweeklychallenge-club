""" Challenge 180 Task 1 LK Python """
from collections import Counter


def first_unique_char(what: str) -> str:
    """Return the first unique character"""

    chars_counter = Counter(what)
    for char in what:
        if chars_counter[char] == 1:
            return char

    return ""


assert first_unique_char("Perl Weekly Challenge") == "P"

assert first_unique_char("Long Live Perl") == "o"

assert first_unique_char("LL") == ""
