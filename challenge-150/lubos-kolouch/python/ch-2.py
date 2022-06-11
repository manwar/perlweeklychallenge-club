from sympy.ntheory import factorint


def get_sq_free_int(limit: int):
    """Get the none-sqare factors number"""
    result = []

    for i in range(1, limit + 1):
        factors = factorint(i)

        if any(value > 1 for value in factors.values()):
            continue

        result.append(str(i))

    return ", ".join(result)


print(get_sq_free_int(500))

assert (
    get_sq_free_int(30)
    == "1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30"
)
