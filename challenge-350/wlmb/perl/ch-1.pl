#!/usr/bin/env perl
# Perl weekly challenge 350
# Task 1:  Good Substrings
#
# See https://wlmb.github.io/2025/12/01/PWC350/#task-1-good-substrings
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to count substrings of Sn of size 3 with no repeated letters.
    FIN
for(@ARGV){
    my $input=$_;
    say "$input -> ", 0+grep{!/(.).*\1/} map {substr $input, $_, 3} 0..length($_)-3
}
