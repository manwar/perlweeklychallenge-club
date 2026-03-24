#!/usr/bin/env python3
"""Challenge 028 - Task 2: Digital Clock.

Display the current time in a simple digital format.
"""

from __future__ import annotations

from datetime import datetime


def main() -> int:
    """Print the current time in HH:MM:SS format."""
    print(datetime.now().strftime("%H:%M:%S"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
