#!/usr/bin/env python

def get_primes():
    primes = []
    # Return a list of all primes between 2 and 50 (being 100 ÷ 2)
    for i in range(2, 51):
        for d in range(2, int(i / 2) + 1):
            # If the number is divisable by something other than one and
            #  itself, it's not a prime
            if i % d == 0:
                break
        else:
            # It's a prime
            primes.append(i)

    return primes


def main():
    primes = get_primes()
    semiprimes = []

    for i in primes:
        for j in primes:
            x = i * j
            if x > 100:
                break
            if x not in semiprimes:
                semiprimes.append(x)

    semiprimes.sort()
    print(*semiprimes, sep=', ')


if __name__ == '__main__':
    main()
