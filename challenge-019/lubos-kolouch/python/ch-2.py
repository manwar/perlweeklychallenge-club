#!/usr/bin/env python3
"""
Challenge 019 - Task 2: Greedy Text Wrapping

Write a script that can wrap the given paragraph at a specified column using
the greedy algorithm.

The greedy algorithm wraps words one at a time, adding each word to the
current line until adding the next word would exceed the column limit.
Then it starts a new line.
"""

import sys


def wrap_text(text: str, column: int = 72) -> str:
    """
    Wrap text at a specified column using the greedy algorithm.

    Args:
        text: The text to wrap
        column: The column width (default: 72)

    Returns:
        The wrapped text with newlines
    """
    if not text:
        return ""

    words = text.split()
    if not words:
        return ""

    result_lines = []
    current_line = []
    current_length = 0

    for word in words:
        word_length = len(word)

        if current_length == 0:
            # First word on the line
            current_line.append(word)
            current_length = word_length
        elif current_length + 1 + word_length <= column:
            # Word fits on current line
            current_line.append(word)
            current_length += 1 + word_length
        else:
            # Word doesn't fit, start new line
            result_lines.append(" ".join(current_line))
            current_line = [word]
            current_length = word_length

    # Add the last line
    if current_line:
        result_lines.append(" ".join(current_line))

    return "\n".join(result_lines)


def main():
    """Main function to wrap text from stdin or arguments."""
    # Read all input
    if len(sys.argv) > 1:
        # Text provided as argument
        text = " ".join(sys.argv[1:])
        column = 72
    else:
        # Read from stdin
        text = sys.stdin.read().strip()
        column = 72

    # Allow specifying column as first argument if numeric
    if len(sys.argv) > 2 and sys.argv[1].isdigit():
        column = int(sys.argv[1])
        text = " ".join(sys.argv[2:])

    print(wrap_text(text, column))


if __name__ == "__main__":
    main()
