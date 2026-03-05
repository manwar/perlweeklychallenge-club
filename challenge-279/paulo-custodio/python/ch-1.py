#!/usr/bin/env python3

import sys

if len(sys.argv) > 2:
    letters = sys.argv[1]
    weights = list(map(int, sys.argv[2:]))
    letters_list = list(letters)

    sorted_letters = sorted(zip(letters_list, weights), key=lambda x: x[1])
    result = ''.join(letter for letter, weight in sorted_letters)
    print(result)
else:
    raise SystemExit("Usage: {} LETTERS WEIGHTS...".format(sys.argv[0]))
