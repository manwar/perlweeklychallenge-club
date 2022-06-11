""" Challenge 153 Task 2"""


def calculate_factorial(what: int):
    """Calculate the factorial"""

    fact = 1

    for i in range(1, what + 1):
        fact *= i

    return fact


def get_factorions_sum(what: int):
    """Get the factorions sum"""

    my_sum = sum(calculate_factorial(int(i)) for i in str(what))

    return my_sum


def is_equal(what: int):
    """Test the equality"""
    return what == get_factorions_sum(what)


assert is_equal(145) == 1
assert is_equal(123) == 0
