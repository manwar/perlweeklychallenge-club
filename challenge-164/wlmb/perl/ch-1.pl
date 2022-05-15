#!/usr/bin/env perl
# Perl weekly challenge 164
# Task 1: Prime palindrome
#
# See https://wlmb.github.io/2022/05/12/PWC164/#task-1-prime-palindrome
use v5.12;
use warnings;
use Math::Prime::Util qw(primes);
say "Output: ", join ", ", grep {$_ eq reverse} @{primes(1000)};
