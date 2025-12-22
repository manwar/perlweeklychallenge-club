#!/usr/bin/env perl
# Perl weekly challenge 353
# Task 1:  Max Words
#
# See https://wlmb.github.io/2025/12/22/PWC353/#task-1-max-words
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the maximum number of space-separated words in the period
    separated phrases contained in the strings Sn.
    FIN
for(@ARGV){
    say "$_ -> ",
        max                # choose maximum
        map {0+            # count words
                 split " " # separate into words
        }
        split /\.\s*/      # separate into sentences
}
