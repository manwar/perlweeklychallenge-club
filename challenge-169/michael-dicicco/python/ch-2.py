def is_achilles(factors, given):
    """Achilles was powerful but imperfect"""
    for factor in factors:
        """a powerful number is divisible by the squares of its prime factors"""
        if not given % factor ** 2 == 0:
            return False
    for i in range(2, 10):
        """a number is a perfect power if it has any integer roots"""
        if nth_root(given, i) % 1 == 0:
            return False
    """the number is powerful and imperfect, like Achilles"""
    return True


def nth_root(some_number, n):
    """raising a number to a fractional power of 1/n is the same as taking the nth root"""
    return some_number ** (1 / n)


def prime_factors(n):
    output = []

    while n % 2 == 0:
        output.append(2)
        n /= 2

    for i in range(3, int(n ** 1 / 2 + 1), 2):
        while n % i == 0:
            output.append(i)
            n /= i

    if n > 2:
        output.append(int(n))
    return output


if __name__ == '__main__':
    print(", ".join([str(i) for i in range(72, 1801) if is_achilles(prime_factors(i), i)]))
