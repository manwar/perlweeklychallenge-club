#!/usr/bin/env python3
"""Challenge 029 - Task 2: Call a C function.

Demonstrate calling a standard C function via ctypes.
This example calls strlen() from the C standard library.
"""

from __future__ import annotations

import ctypes
import sys


def load_c_library() -> ctypes.CDLL:
    """Load the system C library."""
    libc = ctypes.CDLL(None)
    libc.strlen.argtypes = [ctypes.c_char_p]
    libc.strlen.restype = ctypes.c_size_t
    return libc


def c_strlen(text: str) -> int:
    """Return the length of text using C strlen()."""
    libc = load_c_library()
    return int(libc.strlen(text.encode("utf-8")))


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    if len(argv) != 2:
        print(f"Usage: {argv[0]} STRING")
        return 1

    print(c_strlen(argv[1]))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
