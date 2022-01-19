#!/usr/bin/perl

# Challenge 144
#
# TASK #1 > Semiprime
# Submitted by: Mohammad S Anwar
# Write a script to generate all Semiprime number <= 100.
#
# For more information about Semiprime, please checkout the wikipedia page.
#
#
# In mathematics, a semiprime is a natural number that is the product of
# exactly two prime numbers. The two primes in the product may equal each
# other, so the semiprimes include the squares of prime numbers.
#
#
# Example
# 10 is Semiprime as 10 = 2 x 5
# 15 is Semiprime as 15 = 3 x 5

use Modern::Perl;
use ntheory 'semi_primes';

use constant MAX_NUM => 100;

my $n = shift||MAX_NUM;
say join(", ", @{semi_primes($n)});
