#!/usr/bin/env perl
# Perl weekly challenge 358
# Task 1:  Max Str Value
#
# See https://wlmb.github.io/2026/01/26/PWC358/#task-1-max-str-value
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    where each string Sn consists of space separated substrings
    to obtain the maximum value of those substrings. The value is
    the numeric value for strings of digits or the length of the
    string.
    FIN
for(@ARGV){
    say "$_ -> ", max map {/^\d+$/ ? $_ : length }split " "
}
