#!/usr/bin/env python3
""" Returns the nth prime number By Khalid Anwar
"""
def get_nth_prime_number(nth):
  total_number_of_primes = 0
  factor = 2
  s = (nth * factor)
  while total_number_of_primes < nth:
    primes = make_prime(s)
    total_number_of_primes = sum(primes[2:])
    factor += 1
    s = (nth * factor)
  nth_prime_number = count_primes(primes, nth)
  return nth_prime_number

""" using the Sieve of Eratosthenes
"""
def make_prime(k):
  prime = bytearray([1]*k)
  for i in range(2, k):
      if prime[i] == 1:
        for j in range(i, k):
          if i*j < k:
            prime[i*j] = 0
          else:
            break
  return prime

""" Returns the n-th prime 
"""
def count_primes(primes, nth):
  count = 0
  for k in range(2, len(primes)):
    count += primes[k]
    if count == nth:
      return k


def main():
    NTH = 10001
    nth_prime_number = get_nth_prime_number(NTH)
    print("The {}-th prime number is => {}".format(NTH, nth_prime_number))


if __name__ == "__main__":
    main()
