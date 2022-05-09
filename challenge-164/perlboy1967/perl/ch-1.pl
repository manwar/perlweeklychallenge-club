#!/bin/perl

=pod

The Weekly Challenge - 164
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-164/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Prime Palindrome
Submitted by: Mohammad S Anwar

Write a script to find all prime numbers less than 1000, which are also palindromes
in base 10. Palindromic numbers are numbers whose digits are the same in reverse. 
For example, 313 is a palindromic prime, but 337 is not, even though 733 (337 reversed)
is also prime.

=cut

use v5.16;

use Math::Prime::XS qw(primes);

say join ', ', grep { (join '', reverse split//) == $_ } primes(1000);
