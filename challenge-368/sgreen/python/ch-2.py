#!/usr/bin/env python3

import sys


def omega(number: int, mode: int) -> int:
    # List of prime factors for the number
    factors = []

    # The first prime is two
    i = 2

    # Calculate prime factors
    while number > 1:
        if number % i == 0:
            # i is a prime factor. Add it to the list, and evaluate it again
            factors.append(i)
            number //= i
        else:
            # Not a prime factor, evaluate the next number
            i += 1

            # Safety valve
            if i > number:
                raise ValueError("Cannot calculate prime digits")

    # Return the number of prime factors (mode = 1), or unique primes (mode = 0)
    return len(factors) if mode else len(set(factors))


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = omega(array[0], array[1])
    print(result)


if __name__ == "__main__":
    main()
