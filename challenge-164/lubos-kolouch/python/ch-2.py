""" Challenge 164 Task 2"""


def is_happy(what: int) -> bool:
    """Check if a number is happy"""

    results_cache: dict = {}

    while 1:
        result = 0
        for num in str(what):
            result += int(num) * int(num)

        if result == 1:
            return True

        if results_cache.get(result, 0):
            return False

        results_cache[result] = 1
        what = result


def get_happy_numbers() -> list:
    """Get the 8 happy numbers"""

    output: list = []

    pos = 1
    while len(output) < 8:
        if is_happy(pos):
            output.append(pos)
        pos += 1

    return output


assert get_happy_numbers() == [1, 7, 10, 13, 19, 23, 28, 31]
