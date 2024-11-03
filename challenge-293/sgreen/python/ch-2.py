#!/usr/bin/env python3

import sys


def is_boomerang(points: list) -> bool:
    # Check for a flat line (to avoid division by zero error)
    if all(points[0][1] == points[i][1] for i in range(1, len(points))):
           return False

    if any(points[0][1] == points[i][1] for i in range(1, len(points))):
           return True

    degrees = set(abs((points[0][0] - points[i][0]) / (points[0][1] - points[i][1])) for i in range(1, len(points)))
    return False if len(degrees) == 1 else True

def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    points = [[array[i], array[i + 1]] for i in range(0, len(array), 2)]
    result = is_boomerang(points)
    print('true' if result else 'false')


if __name__ == '__main__':
    main()
