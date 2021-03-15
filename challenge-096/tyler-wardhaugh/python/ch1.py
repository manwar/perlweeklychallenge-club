#!/usr/bin/env python3
"""Challenge 96, Task 1"""

import sys
import re

DEFAULT_INPUT = "The Weekly Challenge"

def reverse_words(s):
    """Split a string s into words and reverse their order."""
    words = re.split(r'\s+', s.strip())
    return ' '.join(words[::-1])


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    s = args[0] if args else DEFAULT_INPUT
    print(reverse_words(s))


if __name__ == '__main__':
    sys.exit(main())
