from typing import List


def concatenation_value(ints: list[int]) -> int:
    concat_value = 0
    while len(ints) > 0:
        if len(ints) == 1:
            concat_value += ints[0]
            del ints[0]
        else:
            first = str(ints[0])
            last = str(ints[-1])
            concat = int(first + last)
            concat_value += concat
            del ints[0]
            del ints[-1]
    return concat_value


# Tests
assert concatenation_value([6, 12, 25, 1]) == 1286
assert concatenation_value([10, 7, 31, 5, 2, 2]) == 489
assert concatenation_value([1, 2, 10]) == 112
