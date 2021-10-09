#!/usr/bin/ruby -w
# frozen_string_literal: false

# ch-2.rb

# https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
#
# Task 2 > Smith Numbers
# ======================
#
# Write a script to generate the first 10 `Smith Numbers` in base 10.
#
# According to Wikipedia:
#
# > In number theory, a Smith number is a composite number for which, in a given
# > number base, the sum of its digits is equal to the sum of the digits in its
# > prime factorization in the given number base.

################################################################################
# Our PWC Solution
################################################################################

# First, a utility method to find and return our prime factors
def prime_factors(number)
  factors = []
  while number >= 2 # Starting with 2, divide and check modulo
    if (number % divisor ||= 2).zero? # If modulo is zero, push to `factors`
      factors.push(divisor)
      number /= divisor
    else
      divisor += 1 # Else, increment divisor and try again
    end
  end
  factors
end

# Helper method to reduce number to sum of it digits
def sum_digits(number)
  number.to_s.split(//).map(&:to_i).inject(0, :+)
end

# Method to reduce our primes to the sum of their digits
def sum_primes(primes)
  primes.reduce(0) { |sum, prime| sum + sum_digits(prime) }
end

# Find `Smith Numbers` with our methods, `prime_factors`, `sum_digits`,
# `sum_primes`
def find_smith_numbers(limit)
  smith_numbers = []
  test = 4
  while smith_numbers.length < limit.to_i
    primes = prime_factors(test)
    prime_sum = sum_primes(primes)
    digit_sum = sum_digits(test)
    smith_numbers.push(test) if prime_sum == digit_sum && primes.length > 1
    test += 1
  end
  smith_numbers
end

################################################################################
# Utilities
################################################################################

def list_with_oxford(list)
  last = list.pop
  list.join(', ') + ', and ' + last.to_s
end

################################################################################
# Main
################################################################################

def main(limit)
  smith_numbers = find_smith_numbers(limit.to_i)
  result_str = list_with_oxford(smith_numbers)
  puts "The first #{limit} Smith Number(s) are #{result_str}."
end

main(ARGV.shift || 10)
