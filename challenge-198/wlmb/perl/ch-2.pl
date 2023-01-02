#!/usr/bin/env perl
# Perl weekly challenge 198
# Task 2:  Prime Count
#
# See https://wlmb.github.io/2023/01/02/PWC198/#task-2-prime-count
use v5.36;
use Math::Prime::Util qw(prime_count);
say(<<~"FIN"), exit unless @ARGV;
    Usage: $0 N1 [N2...]
    to fin the number of primes below N1, N2...
    FIN
say "$_ -> ", prime_count($_-1) for @ARGV;
