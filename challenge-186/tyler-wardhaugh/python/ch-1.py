#!/usr/bin/env python3
"""Challenge 186, Task 1"""

import sys
from typing import Any, Generator


DEFAULT_INPUT = [[1, 2, 3], ["a", "b", "c"]]
builtin_zip = zip


def zip(a: Any, b: Any) -> Generator[Any, None, None]:
    """Interleave two lists a and b. This shadows the builtin zip() function,
    which does most of what we want except that it yields tuples."""

    for a_elem, b_elem in builtin_zip(a, b):
        yield a_elem
        yield b_elem


def main(args: list[str] = None) -> None:
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    A, B = None, None
    if args:
        import json
        A, B = map(json.loads, args[0:1])
    else:
        A, B = DEFAULT_INPUT

    print(repr(list(zip(A, B))))


if __name__ == "__main__":
    sys.exit(main())
