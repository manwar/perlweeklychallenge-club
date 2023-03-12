#!/usr/bin/env python3

import sys


def main(n):
    h_index = 0

    for i in range(1, len(n)+1):
        # Count the number of items that are >= i
        count = sum(1 for x in n if x >= i)
        if count >= i:
            h_index = i
        else:
            # No point trying any more, as it will be False.
            break

    print(h_index)


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
