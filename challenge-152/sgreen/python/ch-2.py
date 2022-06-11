#!/usr/bin/env python3

import re
import sys


class Rectangle:
    def __init__(self, x1, y1, x2, y2):
        # Ensure x1 is the left side
        if (x1 > x2):
            (x1, x2) = (x2, x1)
        # Ensure y1 is the bottom side
        if (y1 > y2):
            (y1, y2) = (y2, y1)

        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2

    def area(self):
        # Return the area of the rectangle
        return (self.x2-self.x1) * (self.y2 - self.y1)


def main(s):
    numbers = list(map(int, re.findall(r'-?\d+', s)))

    # Find out the combined area of the two rectangles
    rect1 = Rectangle(*numbers[0:4])
    rect2 = Rectangle(*numbers[4:8])
    area = rect1.area() + rect2.area()

    # Calculate any overlap
    dx1 = max(rect1.x1, rect2.x1)
    dy1 = max(rect1.y1, rect2.y1)
    dx2 = min(rect1.x2, rect2.x2)
    dy2 = min(rect1.y2, rect2.y2)

    # If there is, remove that from the calculations
    if dx1 < dx2 and dy1 < dy2:
        d = Rectangle(dx1, dy1, dx2, dy2)
        area -= d.area()

    print(area)


if __name__ == '__main__':
    main(sys.argv[1])
