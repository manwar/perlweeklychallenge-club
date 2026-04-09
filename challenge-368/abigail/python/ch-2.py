#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    [number, mode] = map (lambda x: int (x), line . rstrip () . split ())

    diff_factors = 0
    factors      = 0

    #
    # Try dividing by all odd numbers -- but use 2 if the number is 1.
    # Count different and total factors.
    #
    # Note that this way, we will never divide by a composite number --
    # if we encounter a composite number, we have already tried its factors.
    #
    d = 1
    while d * d <= number:     # No C-style for loop in Python
        n = 2 if d == 1 else d
        if number % n == 0:
            diff_factors = diff_factors + 1
            while number % n == 0:
                factors = factors + 1
                number  = number // n
        d = d + 2

    #
    # At this point, number is either 1 or a large prime, not encountered
    # before. In the later case, add one of the number of factors and unique
    # factors.
    #
    if number != 1:
        diff_factors = diff_factors + 1
        factors      = factors + 1


    print (factors if mode == 1 else diff_factors)
