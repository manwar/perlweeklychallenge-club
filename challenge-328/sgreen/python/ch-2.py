#!/usr/bin/env python3

import sys


def good_string(input_string: str) -> str:
    solution = input_string
    while True:
        for idx in range(0, len(solution)-1):
            char = solution[idx]
            # If the next two letters are the same but different case, remove them
            if ((char.isupper() and solution[idx + 1] == char.lower()) or
                    (char.islower() and solution[idx + 1] == char.upper())):
                solution = solution[:idx] + solution[idx + 2:]
                break
        else:
            # No pairs were removed
            break

    return solution


def main():
    result = good_string(sys.argv[1])
    print('"' + result + '"')


if __name__ == '__main__':
    main()
