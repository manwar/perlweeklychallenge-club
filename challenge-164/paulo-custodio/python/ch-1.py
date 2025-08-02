#!/usr/bin/env python3

# Challenge 164
#
# Task 1: Prime Palindrome
# Submitted by: Mohammad S Anwar
#
# Write a script to find all prime numbers less than 1000, which are also
# palindromes in base 10. Palindromic numbers are numbers whose digits are the
# same in reverse. For example, 313 is a palindromic prime, but 337 is not, even
# though 733 (337 reversed) is also prime.

import sys

def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def next_prime(n):
    if n <= 1:
        return 2
    p = n
    while not is_prime(p := p + 1):
        pass
    return p

def primes(n):
    p = 2
    prime_list = []
    while p <= n:
        prime_list.append(p)
        p = next_prime(p)
    return prime_list

def palindrome_primes(n):
    prime_list = primes(n)
    return [p for p in prime_list if str(p) == str(p)[::-1]]

print(", ".join(map(str, palindrome_primes(int(sys.argv[1])))))
