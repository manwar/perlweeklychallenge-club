def is_power_of_three(n: int) -> bool:
    """
    Checks if a positive integer is a power of three.

    Args:
        n: The positive integer to check.

    Returns:
        True if n is a power of three, False otherwise.

    Raises:
        ValueError: If n is not a positive integer.
    """

    if n <= 0:
        raise ValueError("Input must be a positive integer.")

    # If n is 1, it's trivially a power of three
    if n == 1:
        return True

    # Repeatedly divide n by 3 until it reaches 1 or becomes negative
    while n % 3 == 0:
        n //= 3

    # If n is 1 after the division, it was a power of three
    return n == 1


# Assert tests (corrected)
assert is_power_of_three(27) is True
assert is_power_of_three(81) is True
assert is_power_of_three(6) is False

print("All tests passed!")
