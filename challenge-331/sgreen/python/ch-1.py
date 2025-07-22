#!/usr/bin/env python3

import re
import sys


def last_word(input_string: str) -> int:
    # Find the last word in the input string and return its length
    match = re.search(
        r"([a-z'-]*[a-z])[^a-z]*$",
        input_string.strip(),
        re.IGNORECASE
    )
    return len(match.group(1)) if match else 0


def main():
    result = last_word(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
