#!/usr/bin/env python3

"""
Challenge 367 - Task #2: Conflict Events
Submitted by Mohammad Sajid Anwar

You are given two events each with start and end time.

Write a script to find out if there is a conflict between the two events.
A conflict happens when two events have some non-empty intersection.
"""

import sys


def time_to_minutes(time_str: str) -> int:
    """Convert HH:MM to minutes since midnight."""
    h, m = map(int, time_str.split(":"))
    return h * 60 + m


def has_conflict(start1: str, end1: str, start2: str, end2: str) -> bool:
    """Return True if two events overlap."""
    s1 = time_to_minutes(start1)
    e1 = time_to_minutes(end1)
    s2 = time_to_minutes(start2)
    e2 = time_to_minutes(end2)
    # Overlap if intervals intersect
    return s1 < e2 and s2 < e1


def main():
    if len(sys.argv) != 5:
        print("Usage: python ch-2.py <start1> <end1> <start2> <end2>")
        sys.exit(1)
    start1, end1, start2, end2 = sys.argv[1:5]
    conflict = has_conflict(start1, end1, start2, end2)
    print(1 if conflict else 0)


if __name__ == "__main__":
    main()
