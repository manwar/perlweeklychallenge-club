
def fill_primes(num):
    i = 2
    while primes[len(primes) - 1] < num:
        i += 1
        cnt = 0
        for p in primes:
            if i % p == 0:
                cnt += 1
        if cnt == 0:
            primes.append(i)

def is_prime(num):
    for p in primes:
        if p < num:
            if num % p == 0:
                return False
        else:
            break
    return True

def primorial(n):
    p = 1
    while n > 0:
        n -= 1
        p *= primes[n]
    return p

def euclid(n):
    return 1 + primorial(n)

primes = [2]
fill_primes(15000)
for i in range(8):
    if not is_prime(euclid(i)):
        print(euclid(i))
        break
