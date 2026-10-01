#!/usr/bin/env python

import math

is_prime = []
def sieve(n):
  # so we always have enough primes, caclulate out to 2n
  n *= 2
  # if we've already calculated primes this far, return
  if len(is_prime) >= n: return
  # extend the sieve to accommodate $n elements
  if len(is_prime) < n:
    is_prime.extend([ True for i in range(n+1 - len(is_prime)) ])
  for i in range(2, int(math.sqrt(n))+2):
    if is_prime[i] == False: continue # already deemed not prime
    for j in range(i ** 2, n+1, i):
      is_prime[j] = False

def prime_step(string):
  ordsum = sum([ ord(c) for c in string ])
  sieve(ordsum) # populate the sieve
  i = 0
  while i < ordsum:
    if is_prime[ordsum + i] or is_prime[ordsum - i]: return i
    i += 1
  return -1; # we should never get here

def solution(string):
  print(f'Input: $str = "{string}"')
  print(f'Output: {prime_step(string)}')

print('Example 1:')
solution("hello")

print('\nExample 2:')
solution("football")

print('\nExample 3:')
solution("a")

print('\nExample 4:')
solution("challenge")

print('\nExample 5:')
solution("perl")
