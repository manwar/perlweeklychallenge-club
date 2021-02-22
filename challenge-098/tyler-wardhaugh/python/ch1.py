#!/usr/bin/env python3
"""Challenge 98, Task 1"""

import atexit
import sys
from pathlib import Path

DEFAULT_INPUT = ('../clojure/resources/input.txt', 4)
FILES = {}


def readN(filename, n):
    """read n characters from the file specified"""
    filename = Path(filename)
    if filename not in FILES:
        FILES[filename] = filename.open()

    fp = FILES[filename]
    if fp is not None:
        result = fp.read(n)
        if result == '':
            fp = None
        return result
    else:
        return None


@atexit.register
def shutdown():
    """close all open file handles"""
    for fp in FILES.values():
        try:
            fp.close()
        except:
            pass


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    filename, n = args[0:1] if args else DEFAULT_INPUT
    n = int(n)

    for _ in range(3):
        chunk = readN(filename, n)
        if chunk is not None:
            print(chunk)


if __name__ == '__main__':
    sys.exit(main())
