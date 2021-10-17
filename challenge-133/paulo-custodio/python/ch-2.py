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

from sympy import isprime

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
    if isprime(n):
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

    