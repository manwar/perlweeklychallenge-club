#!/usr/bin/env python3

import re
import sys


def valid_times(input_string: str) -> int:
    """return the count different ways we can make it a valid time

    Params:
        input_string(str): The time in HH:MM format, optionally with ? replacing numbers

    Returns:
        int: The number of valid time that can be made
    """
    if not re.search(r'^([0-1?][0-9?]|2[0-3?]):[0-5?][0-9?]$', input_string):
        raise ValueError("Input is not in the expected format (HH:MM)")

    # Compute the hours
    if input_string[:2] == "??":
        hours = 24
    elif input_string[:1] == "?":
        hours = 3 if int(input_string[1:2]) < 4 else 2
    elif input_string[1:2] == "?":
        hours = 4 if input_string[:1] == "2" else 10
    else:
        hours = 1

    # Compute the minutes
    if input_string[3:] == "??":
        minutes = 60
    elif input_string[3:4] == "?":
        minutes = 6
    elif input_string[4:] == "?":
        minutes = 10
    else:
        minutes = 1

    return hours * minutes


def main():
    result = valid_times(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
