#!/usr/bin/env python3

import re
import sys


def ball_and_boxes(s: str) -> int:
    # Make sure we have valid input
    if not re.search('^(?:[RGB][0-9])+$', s):
        raise ValueError('Invalid input')

    # Put balls in boxes
    boxes = {}
    for color, box in re.findall('([RGB])([0-9])', s):
        if box not in boxes:
            boxes[box] = set()
        boxes[box].add(color)

    # Count the number of boxes that have three balls
    return sum(1 for b in boxes.values() if len(b) == 3)


def main():
    result = ball_and_boxes(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
