"""

    TASK #1 › Semiprime
    Submitted by: Mohammad S Anwar
    Write a script to generate all Semiprime number <= 100.

    For more information about Semiprime, please checkout the wikipedia page.


    In mathematics, a semiprime is a natural number that is the product of exactly two prime numbers. The two primes in the product may equal each other, so the semiprimes include the squares of prime numbers.


        Example
        10 is Semiprime as 10 = 2 x 5
        15 is Semiprime as 15 = 3 x 5

"""

primes = []
result = []
# Function to obtain all the primes numbers <= 100


def prime_numbers():
    for i in range(2, 101):
        primes.append(i)
        for j in range(2, i):
            if i % j == 0:
                primes.remove(i)
                break
    return primes


# Function to obtain all the semiprimes numbers <= 100
def semi_prime():
    for num in range(2, 101):
        for m in range(len(primes)):
            for n in range(len(primes)):
                if num == (primes[m] * primes[n]) and num not in result:
                    result.append(num)
    return result


prime_numbers()


# Print all the semiprimes numbers in a line, separated by ', '
print(*semi_prime(), sep=", ")
