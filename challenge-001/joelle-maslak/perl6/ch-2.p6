#!/usr/bin/env perl6
use v6;

# Challenge:
#   Write a one-liner to solve the FizzBuzz problem and print the
#   numbers 1 through 20. However, any number divisible by 3 should
#   be replaced by the word ‘fizz’ and any divisible by 5 by the
#   word ‘buzz’. Those numbers that are both divisible by 3 and 5
#   become ‘fizzbuzz’.

# Methodology:
#   I've seen this one before. People tend to get too clever, so this is
#   a fairly simple solution.

for 1..20 -> $i { if $i %% 15 { say "fizzbuzz" } elsif $i %% 5 { say "buzz" } elsif $i %% 3 { say "fizz" } else { say $i } }
