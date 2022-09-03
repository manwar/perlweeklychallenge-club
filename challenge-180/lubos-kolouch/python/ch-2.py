""" Challenge 180 Task 2 LK Python """


def trim_list(what: list, i: int) -> list:
    """Return the trimmed list"""

    return [elem for elem in what if elem > i]


assert trim_list([1, 2, 3, 4, 5], 3) == [4, 5]
assert trim_list([9, 0, 6, 2, 3, 8, 5], 4) == [9, 6, 8, 5]
