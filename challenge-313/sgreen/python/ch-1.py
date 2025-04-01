#!/usr/bin/env python3

import re
import sys


def broken_keys(name: str, typed: str) -> bool:
    r = '^' + '+'.join(map(re.escape, name)) + '+$'
    return bool(re.search(r, typed))


def main():
    result = broken_keys(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
