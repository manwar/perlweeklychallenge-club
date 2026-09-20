#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

from dataclasses import dataclass
from itertools import batched, combinations
import sys


@dataclass
class Box:
    width: int
    height: int


def stackable_box(boxes) -> int:
    """
    Determine if the specified boxes can fit inside each other

    Params:
        boxes: A tuple of boxes

    Returns:
        bool: If they can fit inside each other
    """
    # Check the widths and heights are unique
    box_count = len(boxes)
    if len(set(box.width for box in boxes)) != box_count:
        return False
    if len(set(box.height for box in boxes)) != box_count:
        return False

    # Sort boxes by their width, and make sure their lengths are in order
    sorted_boxes = sorted(boxes, key=lambda box: box.width)
    heights = [box.height for box in sorted_boxes]
    return heights == sorted(heights)


def arrange_box(*boxes) -> int:
    """
    Determine the maximum number of these boxes that can fit inside each other
    in a single stack. For a box to fit inside another, it must be smaller in
    both dimensions.

    Params:
        *boxes: The dimensions of the boxes. If not a Box type, will be converted

    Returns:
        int: The number of boxes that can be stacked.
    """
    boxes = [box if isinstance(box, Box) else Box(*box) for box in boxes]
    for length in range(len(boxes), 1, -1):
        for box_set in combinations(boxes, length):
            if stackable_box(box_set):
                return length

    # Only one box can be used
    return 1


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    boxes = batched(array, 2)
    result = arrange_box(*boxes)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
