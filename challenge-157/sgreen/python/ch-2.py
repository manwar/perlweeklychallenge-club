#!/usr/bin/env python3

import sys


def same_digits(x, b):
    # Record the digit
    d = None

    while x != 0:
        this_digit = x % b
        if d is None:
            # First (right most) digit
            d = this_digit
        elif d != this_digit:
            # Check this digit matches the other one
            return False

        # Divide x by the b allows us to calculate the next right most digit
        x = x // b

    return True


def main(s):
    # Convert string to integer
    n = int(s)

    # Calculate for bases 2 to n-2
    for b in range(2, n-1):
        # Check for n in base b is all the same digits
        if same_digits(n, b):
            print(f"1 (base {b})")
            return

    # Not a brazilian number
    print(0)


if __name__ == '__main__':
    main(sys.argv[1])
