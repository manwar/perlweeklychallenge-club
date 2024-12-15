#!/usr/bin/env python3

import json
import sys


def find_match(matrix, word, positions):
    if word == '':
        # We have a solution
        return True

    # Directions we can move (up, down, left, right)
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    current_row = positions[-1][0]
    current_col = positions[-1][1]
    for direction in directions:
        next_row = current_row + direction[0]
        next_col = current_col + direction[1]
        if next_row < 0 or next_row >= len(matrix) or next_col < 0 or next_col >= len(matrix[0]):
            # We're out of bounds
            continue

        if [next_row, next_col] in positions:
            # We've already used this position
            continue

        if matrix[next_row][next_col] == word[0]:
            # We found a letter at this position. Call the function again to
            #  see if we can find the next letter
            if find_match(
                    matrix,
                    word[1:],
                    [*positions, [next_row, next_col]]
            ):
                return True

    return False


def word_search(matrix: list[list[str]], word: str) -> bool:
    rows = len(matrix)
    cols = len(matrix[0])

    # Check each row has the same number of columns as the first row
    for row in range(rows):
        if len(matrix[row]) != cols:
            raise ValueError("Row %s has the wrong number of columns", row)

    for row in range(rows):
        for col in range(cols):
            if matrix[row][col] == word[0]:
                if find_match(matrix, word[1:], [[row, col]]):
                    return True

    return False


def main():
    # Convert the first value to a list of list of strings
    matrix = json.loads(sys.argv[1])
    result = word_search(matrix, sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
