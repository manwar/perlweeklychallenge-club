#!/usr/bin/env python3

import re
import sys


def validate_codes(codes: list, names: list, status: list) -> list:
    """Validates a list of codes based on specific criteria.

    Args:
        codes (list): A list of codes.
        names (list): A list of names.
        status (list): A list of status ('true' or 'false').

    Returns:
        list: A list of booleans indicating whether each code is valid.
    """
    output = []

    for i in range(len(codes)):
        is_valid = True
        if re.match(r'^[A-Za-z0-9_]+$', codes[i]) is None:
            is_valid = False
        elif names[i] not in ["electronics", "grocery", "pharmacy", "restaurant"]:
            is_valid = False
        elif status[i].lower() == "false":
            # The status is a string of 'true' or 'false', not boolean type.
            is_valid = False
        elif status[i].lower() != 'true':
            raise ValueError(f"Status must be 'true' or 'false', not '{status[i].lower()}'")
        output.append(is_valid)

    return output


def main():
    # Convert input into codes, names, and status
    if len(sys.argv) % 3 != 1:
        raise ValueError("Input arguments must be in multiples of three (code, name, status)")

    codes = []
    names = []
    status = []
    for i in range(1, len(sys.argv), 3):
        codes.append(sys.argv[i])
        names.append(sys.argv[i + 1])
        status.append(sys.argv[i + 2])

    result = validate_codes(codes, names, status)
    print(result)


if __name__ == '__main__':
    main()
