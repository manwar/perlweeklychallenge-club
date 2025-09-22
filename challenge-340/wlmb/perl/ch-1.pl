#!/usr/bin/env perl
# Perl weekly challenge 340
# Task 1:  Duplicate Removals
#
# See https://wlmb.github.io/2025/09/22/PWC340/#task-1-duplicate-removals
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to remove adjacent duplicate characters from the strings S0 S1...
    FIN
for(@ARGV){
    my $input=$_;
    1 while s/(.)\1//g;
    say "$input -> $_"
}
