#!/usr/bin/ruby -w
# frozen_string_literal: false

# ch-1.rb

# https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
#
# Task 1 > Integer Square Root
# ============================
#
# You are given a positive integer `$N`.
#
# Write a script to calculate the integer square root of the given number.
#
# Please avoid using built-in function.  Find out more about it here
# (https://en.wikipedia.org/wiki/Integer_square_root).
#
# Examples
# --------
#
# Input: $N = 10
# Output: 3
#
# Input: $N = 27
# Output: 5
#
# Input: $N = 85
# Output: 9
#
# Input: $N = 101
# Output: 10

################################################################################
# Our PWC Solution
################################################################################

def int_sqr_root(input)
  if !input.integer? || !input.positive?
    puts 'Input must be a positive integer'
    return
  end
  # Crawl through squares starting with 0
  i = 0
  (i += 1) while i * i <= input
  # Return the highest passing number
  i - 1
end

################################################################################
# REPL
################################################################################

def print_banner
  message = 'Integer Square Root Calculator'
  outline = '=' * message.length
  puts "\e[36m\n#{outline}\n#{message}\n#{outline}\n\e[0m"
end

prompt = "Enter a positive integer (or, type \"\e[33mexit\e[0m\" to quit)> "
check_continue = "Try again? (\e[33my\e[0m/\e[33mn\e[0m)> "

print_banner
print prompt

loop do
  input = gets.chomp
  input.strip!
  case input
  when /\A\d+\z/
    puts "Integer square root: #{int_sqr_root(input.to_i)}"
    print check_continue
  when /\Ay\z/
    print prompt
  when /\A(exit|n)\z/
    puts 'Goodbye.'
    exit
  else puts 'Arguments must be positive integers only.'
  end
end
