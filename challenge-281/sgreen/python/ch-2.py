#!/usr/bin/env python3

import re
import sys


def convert_coord_to_list(coord: str) -> list:
    letters = ' abcdefgh'
    return (letters.index(coord[0]), int(coord[1]))


def knights_move(start_coord: str, end_coord: str) -> int:
    '''Calculate the least number of knight moves between two positions'''

    # Check if the position is valid
    for coord in (start_coord, end_coord):
        if not re.search('^[a-h][1-8]$', coord):
            raise ValueError(
                f'The position {coord} is not a valid chess coordinate!')

    # Direction the knight piece can move
    deltas = ([2, 1], [2, -1], [-2, 1], [-2, -1],
              [1, 2], [1, -2], [-1, 2], [-1, -2])

    # Where we start
    coords = [convert_coord_to_list(start_coord)]

    # Where we want to end
    target = convert_coord_to_list(end_coord)

    # Count the required moves
    moves = 1

    # Co-ordinates we've already been to
    seen = []

    while True:
        # The new coordinates after we've made the next move
        new_coords = []

        # For all existing places after the previous move
        for coord in coords:
            # Move the knight in all possible ways
            for delta in deltas:
                new_pos = (coord[0] + delta[0], coord[1] + delta[1])

                # But exclude moves that take it off the board or we've already used
                if not 0 < new_pos[0] < 9 or not 0 < new_pos[1] < 9 or new_pos in seen:
                    continue

                if new_pos == target:
                    # We've hit the target position
                    return moves

                new_coords.append(new_pos)
                seen.append(new_pos)

        # Looks like we'll need to move again!
        coords = new_coords
        moves += 1


def main():
    result = knights_move(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
