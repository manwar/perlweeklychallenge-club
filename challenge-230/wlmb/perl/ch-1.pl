#!/usr/bin/env perl
# Perl weekly challenge 230
# Task 1:  Separate Digits
#
# See https://wlmb.github.io/2023/08/14/PWC230/#task-1-separate-digits
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
   Usage: $0 N1 [N2..]
   to separate the positive integers N1 N2... into their decimal digits.
   FIN
for(@ARGV){ # Check input
    die "Expected only positive integers: $_" unless /^\d+$/;
}
say join " ", @ARGV, " -> ", map {split ""} @ARGV;
