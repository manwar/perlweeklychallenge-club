#!/usr/bin/env perl
# Perl weekly challenge 375
# Task 2:  Find K-Beauty
#
# See https://wlmb.github.io/2026/05/26/PWC375/#task-2-find-k-beauty
use v5.36;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 N0 K0 N1 K1...
    to find how many substrings of Nn of length Kn divide Nn.
    FIN
for my ($n, $k) (@ARGV) {
    say"num=$n  k=$k -> ", 0+grep{ $n%$_ == 0} $n=~/(?=(\d{$k}))/g;
}
