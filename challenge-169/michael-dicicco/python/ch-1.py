def is_brilliant(factors):
    """a brilliant number has only two prime factors of the same length"""
    return len(factors) == 2 and len(str(int(factors[0]))) == len(str(int(factors[1])))


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
    print(", ".join([str(i) for i in range(4, 300) if is_brilliant(prime_factors(i))]))
