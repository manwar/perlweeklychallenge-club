#!/usr/bin/env perl
# Perl weekly challenge 241
# Task 2:  Prime Order
#
# See https://wlmb.github.io/2023/10/30/PWC241/#task-2-prime-order
use v5.36;
use Math::Prime::Util qw(factor);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 [N1...]
    to order the numbers N0 N1 according to the number of factors and their value.
    FIN
say join " ", @ARGV, "->", sort{factor($a)<=>factor($b) || $a <=> $b} @ARGV
