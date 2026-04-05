#!/usr/bin/env python3

from itertools import batched
import re
import sys


def hm2m(t: str) -> int:
    """Convert a HH:MM formatted string to minutes since midnight"""
    if not re.search(r'^([0-1][0-9]|2[0-3]):[0-5][0-9]$', t):
        raise ValueError("Input is not in the expected format (HH:MM)")

    return int(t[:2]) * 60 + int(t[3:])


def conflict_events(events) -> bool:
    """Determine if there is a conflict between two or more events.

    Params:
        events(list): A list of start and end times in HH:MM format

    Returns:
        bool: Whether two events conflict (occur at the same time)
    """
    event_minutes = []
    for event in events:
        # Convert times into minutes since midnight
        start_minute = hm2m(event[0])
        end_minute = hm2m(event[1])
        if start_minute == end_minute:
            # There is no intersection of a single point in time
            continue

        if end_minute < start_minute:
            # Time spans midnight
            event_minutes.extend(
                [range(start_minute, 1440), range(0, end_minute)])
        else:
            event_minutes.append(range(start_minute, end_minute))

    # Check if any minutes overlap
    minutes = set()
    for r in event_minutes:
        for minute in r:
            if minute in minutes:
                # A minute appears in more than one range.
                return True
            minutes.add(minute)

    # No conflicts found. Woohoo!
    return False


def main():
    # Convert input into time pairs pairs
    events = batched(sys.argv[1:], 2, strict=True)
    result = conflict_events(events)
    print(result)


if __name__ == "__main__":
    main()
