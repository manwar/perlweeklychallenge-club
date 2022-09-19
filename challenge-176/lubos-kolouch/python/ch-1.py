""" Challenge 176 Task 1 Python LK """


def get_permuted_multiple() -> int:
    """Get the first number matching"""

    i = 0
    while 1:
        i += 1

        is_var_ok = 1

        for j in range(2, 7):
            if "".join(sorted(str(i))) != "".join(sorted(str(i * j))):
                is_var_ok = 0
                break

        if is_var_ok:
            return i


assert get_permuted_multiple() == 142857
