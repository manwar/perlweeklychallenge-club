class Point:
    def __init__(self, x: int, y: int):
        self.x = x
        self.y = y


class Rectangle:
    def __init__(self, left: Point, right: Point):
        self.left = left
        self.right = right

    def get_area(self) -> int:
        return abs(self.left.x - self.right.x) * abs(self.left.y -
                                                     self.right.y)


def get_total_area(first: Rectangle, second: Rectangle) -> int:
    area1 = first.get_area()
    area2 = second.get_area()

    # calculate the overlapping area
    x_dist = min(first.right.x, second.right.x) - \
     max(first.left.x, second.left.x)
    y_dist = min(first.right.y, second.right.y) - \
     max(first.left.y, second.left.y)
    area_i = 0
    if x_dist > 0 and y_dist > 0:
        area_i = x_dist * y_dist

    return area1 + area2 - area_i


first = Rectangle(Point(-1, 0), Point(2, 2))
second = Rectangle(Point(0, -1), Point(4, 4))

if get_total_area(first, second) != 22:
    raise Exception("Failed test 1")

first = Rectangle(Point(-3, -1), Point(1, 3))
second = Rectangle(Point(-1, -3), Point(2, 2))

if get_total_area(first, second) != 25:
    raise Exception("Failed test 2")
