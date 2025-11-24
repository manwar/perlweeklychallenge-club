#!/usr/bin/env python3

import re
import sys

def time_to_minute(s: str) -> int:
    if not re.match(r'^\d{1,2}:\d{2}$', s):
        raise ValueError("Invalid time format, should be HH:MM")

    hour, minute = map(int, s.split(':'))

    if hour < 0 or hour > 23 or minute < 0 or minute > 59:
        raise ValueError("Invalid time format")

    return hour * 60 + minute


def convert_time(source: str, target: str) -> int:
    # Convert the time to minutes past midnight, and calculate the minutes
    #  between them
    duration = time_to_minute(target) - time_to_minute(source)
    if duration < 0:
        # Adjust for next day
        duration += 24 * 60

    # Possible increments in minutes
    moves = [60, 15, 5, 1]
    count = 0

    for move in moves:
        # Use as many of this move as possible
        count += duration // move

        # The remaining minutes
        duration %= move

    return count


def main():
    result = convert_time(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
