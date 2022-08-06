""" Challenge 176 Task 2 LK Python """


def is_reversible_num(what: int) -> bool:
    """Check if the number is reversible"""

    my_sum = what + int("".join(str(what)[::-1]))

    for i in str(my_sum):
        if int(i) % 2 == 0:
            return False

    return True


def get_numbers(limit: int) -> list:
    """Get the numbers until the limit"""

    i = 1

    result = []

    while i < limit:
        i += 1

        if is_reversible_num(i):
            result.append(i)

    return result


assert get_numbers(100) == [
    10,
    12,
    14,
    16,
    18,
    21,
    23,
    25,
    27,
    30,
    32,
    34,
    36,
    41,
    43,
    45,
    50,
    52,
    54,
    61,
    63,
    70,
    72,
    81,
    90,
]
