""" Challenge 267 Task 2 LK Python"""

from typing import Tuple, List


def line_counts(s: str, widths: List[int]) -> Tuple[int, int]:
    """
    Calculates the number of lines and the width of the last line required to display a string.

    Args:
    s (str): The input string consisting of lowercase English letters.
    widths (List[int]): A list of 26 integers representing the width of each character from 'a' to 'z'.

    Returns:
    Tuple[int, int]: A tuple containing the number of lines used and the width of the last line.
    """
    max_width = 100
    current_width = 0
    lines = 1

    for char in s:
        char_width = widths[ord(char) - ord("a")]
        if current_width + char_width > max_width:
            lines += 1
            current_width = char_width
        else:
            current_width += char_width

    return lines, current_width


# Test cases
assert line_counts("abcdefghijklmnopqrstuvwxyz", [10] * 26) == (3, 60)
assert line_counts("bbbcccdddaaa", [4, 10] + [10] * 24) == (2, 4)

# Print results for visualization
print(line_counts("abcdefghijklmnopqrstuvwxyz", [10] * 26))  # Output: (3, 60)
print(line_counts("bbbcccdddaaa", [4, 10] + [10] * 24))  # Output: (2, 4)
