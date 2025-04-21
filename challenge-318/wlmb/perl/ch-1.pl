#!/usr/bin/env perl
# Perl weekly challenge 318
# Task 1:  Group Position
#
# See https://wlmb.github.io/2025/04/21/PWC318/#task-1-group-position
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to find groups of three or more repeated characters within
    the strings S1, S2...
    FIN
my $counter=0;
say "$_ -> ",
    join ", ",
    grep {$counter++%2==0}    # keep even numbered elements
    /((.)\2{2,})/g            # find 3 or more repetitions of a character
                              # return group and character
    for @ARGV;
