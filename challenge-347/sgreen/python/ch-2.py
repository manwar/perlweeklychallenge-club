#!/usr/bin/env python3

import re
import sys


def format_phone(input_string: str) -> str:
    # Strip all non-digit characters
    input_string = re.sub(r'\D', '', input_string)

    parts = []
    while input_string:
        # Decide length of next part
        l = 2 if len(input_string) == 4 else min(3, len(input_string))
        parts.append(input_string[:l])
        input_string = input_string[l:]

    return '-'.join(parts)


def main():
    result = format_phone(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
