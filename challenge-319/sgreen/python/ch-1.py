#!/usr/bin/env python3

import re
import sys


def word_count(words: list[str]) -> int:
    return sum(1 for word in words if re.search('^[aeiou]', word) or re.search('[aeiou]$', word))


def main():
    result = word_count(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
