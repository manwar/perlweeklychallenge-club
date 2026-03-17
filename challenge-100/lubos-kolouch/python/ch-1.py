#!/usr/bin/python3
"""
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge #100
#               Task 1
#       AUTHOR: Lubos Kolouch
#      CREATED: 02/20/2021 10:16:51 AM
#===============================================================================
"""

from datetime import datetime


def convert_time(inp_time):
    """Convert the time as required"""

    normalized_time = inp_time.strip().replace(" ", "").upper()
    has_meridiem = normalized_time.endswith(("AM", "PM"))
    parse_pattern = "%I:%M%p" if has_meridiem else "%H:%M"
    out_pattern = "%H:%M" if has_meridiem else "%I:%M%p"

    converted_time = datetime.strptime(normalized_time, parse_pattern)
    return converted_time.strftime(out_pattern)


def run_tests():
    """Run basic challenge examples."""

    test_cases = {
        "05:15pm": "17:15",
        "05:15 pm": "17:15",
        "19:15": "07:15PM",
    }

    for value, expected in test_cases.items():
        result = convert_time(value)
        if result != expected:
            raise ValueError(f"{value} converted to {result}, expected {expected}")


if __name__ == "__main__":
    run_tests()
