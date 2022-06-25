"""
    Write a script to generate first 10 Primorial Numbers.

    Primorial numbers are those formed by multiplying successive prime numbers.

    For example,

        P(0) = 1    (1)
        P(1) = 2    (1x2)
        P(2) = 6    (1x2×3)
        P(3) = 30   (1x2×3×5)
        P(4) = 210  (1x2×3×5×7)

"""


maxi = 10
primes = []


# Function to obtain all the primes numbers <= 100
def prime_numbers():
    for i in range(2, 101):
        primes.append(i)
        for j in range(2, i):
            if i % j == 0:
                primes.remove(i)
                break
    primes.insert(0, 1)
    return primes


def primorial_numbers(primes_values):
    counter = 0
    valor = 1
    for num in primes_values:
        if counter < maxi:
            valor = valor * num
            print(f"P({counter}) = {valor}")
            counter += 1


primorial_numbers(prime_numbers())
