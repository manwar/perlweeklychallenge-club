from sympy import factorint, isprime


def home_prime(n):

    while not isprime(n):
        factors = factorint(n)

        my_sum = ""
        for (my_factor, repetition) in factors.items():
            my_sum += str(my_factor) * repetition

        n = int(my_sum)

    return n


assert home_prime(2) == 2
assert home_prime(10) == 773
