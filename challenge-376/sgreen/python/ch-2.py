#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

import re
import sys


def doubled_words(input_string: str) -> str:
    """
    Find doubled words (such as “this this”) and highlight (wrap in brackets)
    each doubled word, following a set of rules

    Params:
        input_string (str): The string to manipulate

    Returns:
        str: Lines that have changed (may include newline characters)
    """

    # Split the words and HTML tags from the other parts of the string
    regexp = r"(<[^>]+>|[a-z0-9]+(?:['-][a-z0-9]+)*)"
    parts = re.split(regexp, input_string, flags=re.IGNORECASE)

    # Find the position of all the words (exclude non words and HTML tags)
    word_positions = [
        i
        for i, word in enumerate(parts)
        if i % 2 == 1 and word[0] != "<" and word[-1] != ">"
    ]

    # Find any double words and alter as needed
    for pos in range(len(word_positions)-1):
        this_pos = word_positions[pos]
        next_pos = word_positions[pos+1]
        if parts[this_pos].lower() == parts[next_pos].lower():
            parts[this_pos] = f"[{parts[this_pos]}]"
            parts[next_pos] = f"[{parts[next_pos]}]"

    # Split into lines
    input_lines = re.split(r"[\r\n]+", input_string)
    output_lines = re.split(r"[\r\n]+", "".join(parts))

    # Find the lines that are different from the original
    different_lines = [
        output
        for i, output in enumerate(output_lines)
        if output != input_lines[i]
    ]

    return "\n".join(different_lines)


def main():
    """Convert command line input into parameters for the function and display result"""
    result = doubled_words(sys.argv[1].replace(r"\n", "\n"))
    print('"' + result.replace("\n", r"\n") + '"')


# Call main if run from the command line
if __name__ == "__main__":
    main()
