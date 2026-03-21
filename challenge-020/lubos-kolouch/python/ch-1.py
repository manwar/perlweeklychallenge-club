#!/usr/bin/env python3
"""
Challenge 020 - Task 1: Split String on Character Change

Write a script to accept a string from command line and split it on change
of character. For example, if the string is "ABBCDEEF", then it should split
like "A", "BB", "C", "D", "EE", "F".
"""

import sys


def split_on_change(text: str) -> list[str]:
    """
    Split a string on change of character.

    Args:
        text: The input string to split

    Returns:
        List of string segments where each segment has identical consecutive characters
    """
    if not text:
        return []

    # Use a simple loop-based approach to group identical consecutive characters
    result = []
    if not text:
        return result

    current_char = text[0]
    current_group = current_char

    for char in text[1:]:
        if char == current_char:
            current_group += char
        else:
            result.append(current_group)
            current_char = char
            current_group = char

    result.append(current_group)
    return result


def main():
    """Main function to split string from command line argument."""
    if len(sys.argv) < 2:
        print("Usage: python ch-1.py <string>")
        print("Example: python ch-1.py ABBCDEEF")
        sys.exit(1)

    text = sys.argv[1]
    result = split_on_change(text)

    # Print as quoted, comma-separated
    print(", ".join(f'"{segment}"' for segment in result))


if __name__ == "__main__":
    main()
