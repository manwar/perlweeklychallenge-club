#!/usr/bin/env python3
"""Challenge 186, Task 2"""

import sys
from unicodedata import normalize


DEFAULT_INPUT = ["ÃÊÍÒÙ"]


def makeover(s: str) -> str:
    return normalize("NFKD", s).encode("ascii", "ignore").decode()


def main(args: list[str] = None) -> None:
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    N = args[0] if args else DEFAULT_INPUT[0]
    print(makeover(N))


if __name__ == "__main__":
    sys.exit(main())
