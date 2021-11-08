#!/usr/bin/env python3

# TASK #2 > Smith Numbers
# Submitted by: Mohammad S Anwar
# Write a script to generate first 10 Smith Numbers in base 10.
#
# According to Wikipedia:
#
# In number theory, a Smith number is a composite number for which, in a given
# number base, the sum of its digits is equal to the sum of the digits in its
# prime factorization in the given number base.
#

def is_prime(n):
    if n <= 1:
        return 0
    elif n <= 3:
        return 1
    elif n % 2 == 0 or n % 3 == 0:
        return 0
    else:
        for i in range(5, n+1, 6):
            if i*i>n:
                break
            if n % i == 0 or n % (i+2) == 0:
                return 0
        return 1

def get_prime_factors(n):
    i = 2
    prime_factors = []
    while i*i <= n:
        if n%i == 0:
            prime_factors.append(i)
            n //= i
        else:
            i += 1

    if n>1:
        prime_factors.append(n)

    return prime_factors

def is_smith(n):
    if is_prime(n):
        return False
    digits = [int(x) for x in str(n)]
    sum1 = sum(digits)
    factors = ''.join([str(x) for x in get_prime_factors(n)])
    fact_digits = [int(x) for x in factors]
    sum2 = sum(fact_digits)
    return sum1==sum2

n=1
count=0
while count<10:
    n+=1
    if is_smith(n):
        print(n)
        count+=1
