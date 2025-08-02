#!/usr/bin/env python3

import sys


def replace_all_questions(input_string: str) -> str:
    solution = ''
    for idx, char in enumerate(input_string):
        if char != '?':
            solution += char
            continue

        # Get the surrounding characters
        letters = []
        if idx > 0:
            letters.append(input_string[idx - 1])
        if idx < len(input_string) - 1:
            letters.append(input_string[idx + 1])

        # Replace '?' with 'a', 'b', or 'c' based on surrounding characters
        if 'a' not in letters:
            solution += 'a'
        elif 'b' not in letters:
            solution += 'b'
        else:
            solution += 'c'

    return solution


def main():
    result = replace_all_questions(sys.argv[1])
    print('"' + result + '"')


if __name__ == '__main__':
    main()
