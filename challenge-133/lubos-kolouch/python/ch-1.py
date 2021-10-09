""" The Weekly Challenge 133 Task 1 """


def get_square_root(what: int, low: int = 0, high: int = 0):
    """ Calculate the square root using interval halving"""

    if not high:
        high = what

    middle = int((high + low) / 2)
    incr_middle = middle + 1

    if middle * middle <= what <= incr_middle * incr_middle:
        return middle

    if middle * middle > what:
        middle = get_square_root(what, low, middle)

    else:
        middle = get_square_root(what, middle, high)

    return middle


assert get_square_root(10) == 3
assert get_square_root(27) == 5
assert get_square_root(85) == 9
assert get_square_root(101) == 10
