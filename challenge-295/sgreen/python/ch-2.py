#!/usr/bin/env python3

import sys


def jump_game(ints: list, moves=1) -> int:
    # Calculate the minimum number of moves from this point
    min_moves = None
    for i in range(ints[0], 0, -1):
        # We can complete the jump with this move
        if i >= len(ints)-1:
            return moves

        # Skip if we can't move forward
        if ints[i] == 0:
            continue

        # Call the function again jumping 'i' positions
        m = jump_game(ints[i:], moves+1)
        if m is not None and (min_moves is None or min_moves > m):
            min_moves = m

    return min_moves


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = jump_game(array)
    print(-1 if result is None else result)


if __name__ == '__main__':
    main()
