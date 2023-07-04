#!/usr/bin/env perl
# Perl weekly challenge 223
# Task 1:  Count Primes
#
# See https://wlmb.github.io/2023/06/27/PWC223/#task-1-count-primes
use v5.36;
use Math::Prime::Util qw(prime_count);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find out how many primes there are upto N1, N2...
    FIN
say "There are ", prime_count($_), " primes below $_" for @ARGV;
