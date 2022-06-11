#!/usr/bin/env python3

import sys


def main(s):
    # Split the input on pipes
    rows = s.split('|')
    min_depth = 1

    for row in rows[1:]:
        # Split the row, and expand if missing values
        v = row.strip().split()
        while len(v) < 2 ** min_depth:
            v.append('*')

        # Go through each pair, and exit if we find two '*'
        for i in range(0, len(v), 2):
            if v[i] == '*' and v[i+1] == '*':
                break
        else:
            min_depth += 1
            continue

        break

    print(min_depth)


if __name__ == '__main__':
    main(sys.argv[1])
