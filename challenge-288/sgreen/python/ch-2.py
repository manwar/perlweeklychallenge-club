#!/usr/bin/env python3

import json
import sys


def find_block(matrix, seen, row, col):
    rows = len(matrix)
    cols = len(matrix[0])

    # The character that we need to match
    char = matrix[row][col]

    # The directions we can move: Up, down, left, right
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

    # Mark the we have seen the starting cell
    seen[row][col] = True

    # Add the starting cell to the stack
    stack = [[row, col]]
    count = 1

    while stack:
        # Whether we found a move from the last value in the stack
        new_pos = False

        for move in directions:
            # Move in each direction
            new_row = stack[-1][0] + move[0]
            new_col = stack[-1][1] + move[1]

            # Check that the move is still in bounds of the matrix, we haven't
            #  already use that position, and it is the correct character
            if new_row < 0 or new_row >= rows or new_col < 0 or new_col >= cols or seen[new_row][new_col] or matrix[new_row][new_col] != char:
                continue

            # It is, add it to the stack, and increment the count
            stack.append([new_row, new_col])
            seen[new_row][new_col] = True
            new_pos = True
            count += 1

        if not new_pos:
            # We didn't find a new move, remove it from that stack.
            stack.pop()

    return count


def contiguous_block(matrix: list) -> int:
    rows = len(matrix)
    cols = len(matrix[0])
    max_block = 0

    # Seed the seen table
    seen = []
    for i in range(rows):
        seen.append([0] * cols)

    for row in range(rows):
        for col in range(cols):
            if seen[row][col]:
                # The item at this position has already been used
                continue

            # Find how many items in this block. If greater than max_block, replace it
            count = find_block(matrix, seen, row, col)
            if count > max_block:
                max_block = count

    return max_block


def main():
    matrix = json.loads(sys.argv[1])
    result = contiguous_block(matrix)
    print(result)


if __name__ == '__main__':
    main()
