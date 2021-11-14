def is_lychrel_number(what: int):

    """ Check if the number is Lychrel """
    iter_count = 0

    while iter_count < 500:
        iter_count += 1

        what += int(str(what)[::-1])

        if what >= 10_000_000:
            break

        if what == int(str(what)[::-1]):
            return 0
    return 1


assert is_lychrel_number(56) == 0
assert is_lychrel_number(57) == 0
assert is_lychrel_number(59) == 0
assert is_lychrel_number(10911) == 1
