#!/usr/bin/env python3

import re
from collections import defaultdict


def balls_and_boxes(locations):
    """ There are $n balls of mixed colors: red, blue or green. They are all
    distributed in 10 boxes labelled 0-9.  Given a string describing the
    location of balls, return the number of boxes containing all three colors,
    return 0 if none found.

    >>> balls_and_boxes("G0B1R2R0B0")
    1
    >>> balls_and_boxes("G1R3R6B3G6B1B6R1G3")
    3
    >>> balls_and_boxes("B3B2G1B3")
    0
    """
    boxes = defaultdict(set)
    for ball in re.findall(r"\w\d", locations):
        boxes[ball[1]].add(ball[0])
    return sum(1 for v in boxes.values() if len(v) == 3)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
