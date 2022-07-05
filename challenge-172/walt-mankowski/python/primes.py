from math import sqrt

# find the primes up to n using the sieve of Eratosthenes and return
# them as a list
def primes_to(n):
    is_prime = [True] * (n+1)
    is_prime[0] = is_prime[1] = False
    for i in range(2, int(sqrt(n))+1):
        if is_prime[i]:
            for j in range(i+i, n+1, i):
                is_prime[j] = False

    return [i for i,val in enumerate(is_prime) if val]

    
