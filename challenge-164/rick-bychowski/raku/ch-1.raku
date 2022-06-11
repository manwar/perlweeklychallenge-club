#!/usr/bin/env raku

# Task 1: Prime Palindrome
#  find all prime numbers less than 1000, which are also palindromes in base 10
#
say (1 ... 999).grep( *.is-prime).grep({ $_ eq .flip})
