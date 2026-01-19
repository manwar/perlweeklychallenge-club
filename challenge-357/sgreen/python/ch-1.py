#!/usr/bin/env python3

import sys


def kaprekar_constant(number: int) -> int:
    """
    Calculate the number of iterations until we reach the Kaprekar Constant

    Params:
        number(int): The initial number

    Returns:
        int: The number of moves, or -1 if it is not possible.
    """
    if not 0 < number < 10000:
        return -1

    # Single repeating digits don't have a solution
    if number % 1111 == 0:
        return -1

    count = 0
    while number != 6174:
        # Compute the largest and smallest values (by sorted the digits numerically)
        digits = [int(d) for d in str(number).zfill(4)]
        asc_digits = sorted(digits)
        desc_digits = sorted(digits, reverse=True)
        small_num = int(''.join(map(str, asc_digits)))
        large_num = int(''.join(map(str, desc_digits)))

        # Set number to be the difference between the two, increment the count
        #  and repeat the loop if number is not 6174.
        number = large_num - small_num
        count += 1

    return count


def main():
    # Convert input into integers
    result = kaprekar_constant(int(sys.argv[1]))
    print(result)


if __name__ == "__main__":
    main()
