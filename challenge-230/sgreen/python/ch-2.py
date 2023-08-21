#!/usr/bin/env python3

import sys


def main(words, prefix):
    solution = sum(1 for word in words if word.lower().startswith(prefix.lower()))
    print(solution)


if __name__ == '__main__':
    # The last input is the prefix
    prefix = sys.argv.pop()
    main(sys.argv[1:], prefix)
