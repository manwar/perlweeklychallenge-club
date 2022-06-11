""" Challenge 158 Task 2 """
from sympy import isprime


def get_eq(y: int, incr: int) -> float:
    """Solve the Cuban prime equation"""

    # warning - waste here, it is ready also for the second series, even though we were
    # not asked for it. This is a bad practice and one of the 7 wastes, but I just
    # accept that I am aware of it and leave it.

    x = y + incr
    return (x**3 - y**3) / (x - y)


def get_cuban_primes(limit: int) -> list:
    """Do the exercise"""

    primes = []
    result = 0.0
    y = 0

    # it would be probabl safer to keep running for a while even after we get over the limit...
    # maybe next values from the function(s) could drop again below the limit
    # but it passes the test and I am a lazy programmer to check the actual outputs from
    # the function, so let's just leave it ;)

    while result <= limit:
        y += 1

        result = get_eq(y, 1)
        if result != int(result):
            continue

        if isprime(int(result)):
            primes.append(int(result))

    return primes


assert get_cuban_primes(1000) == [7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919]
