""" Challenge 173 Task 1 LK """


def is_esthetic_number(what: int) -> bool:
    """Check if the number is esthetic"""

    for pos, num in enumerate(str(what)[0:-1]):
        if abs(int(num) - int(str(what)[pos + 1])) != 1:
            return False

    return True


assert is_esthetic_number(5456) == 1
assert is_esthetic_number(120) == 0
