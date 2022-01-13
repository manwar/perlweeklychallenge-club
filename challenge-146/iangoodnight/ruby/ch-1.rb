#!/usr/bin/ruby -w
# ch-1.rb

# > https://theweeklychallenge.org/blog/perl-weekly-challenge-146/
#
# ## Task 1 > 10001st Prime Number
# ================================
#
# Write a script to generate the 10001st prime number.

################################################################################
# PWC Solution #################################################################
################################################################################

def get_prime(nth)
  primes = [2, 3]
  cursor = 5
  until primes.length >= nth
    is_prime = true
    primes.each do |prime|
      (prime > Math.sqrt(cursor) || !is_prime) && break
      (cursor % prime).zero? && is_prime = false
    end
    is_prime && primes.push(cursor)
    cursor += 2
  end
  nth <= 2 ? primes[nth - 1] : primes.pop
end

################################################################################
# Utilities ####################################################################
################################################################################

def get_suffix(num)
  last = num.to_s[-1].to_i
  return 'th' if last.zero? || last >= 4
  return 'st' if last == 1
  return 'nd' if last == 2
  return 'rd' if last == 3
  ''
end

def print_colors(str, color)
  reset = "\e[0m"
  case color
  when 'yellow'
    "\e[33m#{str}#{reset}"
  when 'green'
    "\e[32m#{str}#{reset}"
  else
    str
  end
end

################################################################################
# Main #########################################################################
################################################################################

nth = ARGV[0] ? ARGV[0].to_i : 10_001
prime = get_prime(nth)
suffix = get_suffix(nth)
num_str = print_colors(nth.to_s + suffix, 'yellow')
prime_str = print_colors(prime, 'green')

puts "The #{num_str} prime number is #{prime_str}"
