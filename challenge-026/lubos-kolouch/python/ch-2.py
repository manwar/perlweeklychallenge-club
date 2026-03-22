#!/usr/bin/env python3
"""Challenge 026 - Task 2: Mean angle.

Given a list of angles in degrees, compute the circular mean.
"""

from __future__ import annotations

import math
import sys


def mean_angle(degrees: list[float]) -> float:
    """Return the circular mean of angles in degrees."""
    if not degrees:
        raise ValueError("At least one angle is required")

    radians = [math.radians(angle) for angle in degrees]
    x = sum(math.cos(angle) for angle in radians)
    y = sum(math.sin(angle) for angle in radians)
    mean = math.degrees(math.atan2(y, x))
    return mean % 360.0


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    if len(argv) < 2:
        print(f"Usage: {argv[0]} ANGLE [ANGLE ...]")
        return 1

    angles = [float(x) for x in argv[1:]]
    print(f"{mean_angle(angles):.1f}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
