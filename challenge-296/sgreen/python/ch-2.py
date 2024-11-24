#!/usr/bin/env python3

import sys


def make_side(sticks: list, l: int) -> list:
    pieces = sorted(set(sticks), reverse=True)

    # Go through each unique stick lengths (highest first)
    for piece in pieces:
        if piece > l:
            # Too long to use for this side
            continue

        if piece == l:
            # We have found the final stick length for this side
            return [piece]

        # Try this stick length and call the function again to find another
        #  stick to use
        sticks_copy = sticks.copy()
        sticks_copy.remove(piece)
        result = make_side(sticks_copy, l - piece)
        if result:
            # We have a solution. Send it upstream
            return [piece, *result]

    # No combination of sticks make up the required length
    return False


def matchstick_square(sticks: list) -> str:
    # Make sure we have of a number of sticks that is devisable by four
    if sum(sticks) % 4:
        return False

    side_length = sum(sticks) // 4

    # No stick can be longer than the length of a side
    if any(i > side_length for i in sticks):
        return False

    while sticks:
        side = make_side(sticks, side_length)
        if not side:
            return False
        for stick in side:
            sticks.remove(stick)

    return True


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = matchstick_square(array)
    print(result)


if __name__ == '__main__':
    main()
