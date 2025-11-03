#!/usr/bin/env python3

import sys


def last_visitor(ints: list[int]) -> list[int]:
    seen = []
    ans = []
    neg_count = 0

    for i in ints:
        if i > 0:
            seen.insert(0, i)
            neg_count = 0
        elif i == -1:
            if neg_count < len(seen):
                ans.append(seen[neg_count])
            else:
                ans.append(-1)
            neg_count += 1
        else:
            raise ValueError("Input integers must be positive or -1.")

    return ans

def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = last_visitor(array)
    print('(' + ', '.join(map(str, result)) + ')')


if __name__ == '__main__':
    main()
