#!/usr/bin/env perl
# Perl weekly challenge 230
# Task 2:  Count Words
#
# See https://wlmb.github.io/2023/08/14/PWC230/#task-2-count-words
use v5.36;
die <<~"FIN" unless @ARGV>=2;
    Usage: $0 prefix W1 [W2...]
    to count how many of the words W1, W2... start with the prefix.
    FIN
my ($prefix ,@words)=@ARGV;
say "Prefix: $prefix, Words: @words, Count: ", 0+grep {/^$prefix/} @words;
