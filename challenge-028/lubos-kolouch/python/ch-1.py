#!/usr/bin/env python3
"""Challenge 028 - Task 1: Binary or ASCII.

Check a file without explicitly reading it into memory and determine whether
it looks like binary or ASCII content.
"""

from __future__ import annotations

import mmap
import sys
from pathlib import Path


def is_binary_file(path: str) -> bool:
    """Return True if the file contains a NUL byte."""
    with open(path, "rb") as fh:
        if fh.seek(0, 2) == 0:
            return False
        with mmap.mmap(fh.fileno(), 0, access=mmap.ACCESS_READ) as mm:
            return b"\x00" in mm


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    if len(argv) != 2:
        print(f"Usage: {Path(argv[0]).name} FILE")
        return 1

    print(
        "The file content is binary."
        if is_binary_file(argv[1])
        else "The file content is ascii."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
