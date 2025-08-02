#!/usr/bin/env python3

import sys

def is_nice_string(s: str) -> bool:
    # Check that every letter has a matching letter in the opposite case
    for letter in s:
        if letter.islower() and letter.upper() not in s:
            return False
        if letter.isupper() and letter.lower() not in s:
            return False
    return True


def nice_string(input_string: str) -> str|None:
    solution = None
    # Calculate every combination of starting and ending positions
    for start in range(len(input_string)-1):
        for end in range(start+2, len(input_string)+1):
            # See if this is a nice string
            extract = input_string[start:end]
            if is_nice_string(extract):
                # If it is longer than the current nice string, update the solution variable
                if solution is None or len(solution) < len(extract):
                    solution = extract

    return solution


def main():
    result = nice_string(sys.argv[1])
    if result is None:
        result = ''
    print('"'+result+'"')


if __name__ == '__main__':
    main()
