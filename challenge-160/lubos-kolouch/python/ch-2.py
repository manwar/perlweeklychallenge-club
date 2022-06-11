""" Challenge 160 Task 2 """


def get_eq_index(what: list) -> int:
    """Get the Equilibrium Index"""

    elem_count = len(what)

    for i in range(1, elem_count - 1):
        if sum(what[0:i]) == sum(what[i + 1 : elem_count]):
            return i

    return -1


assert get_eq_index([1, 3, 5, 7, 9]) == 3
assert get_eq_index([1, 2, 3, 4, 5]) == -1
assert get_eq_index([2, 4, 2]) == 1

assert get_eq_index([2]) == -1
