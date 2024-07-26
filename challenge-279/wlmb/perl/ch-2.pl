#!/usr/bin/env perl
# Perl weekly challenge 279
# Task 2:  Split String
#
# See https://wlmb.github.io/2024/07/22/PWC279/#task-2-split-string
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to check if string Si may be split into strings with the same
    number of vowels each.
    FIN
say "$_ -> ", tr/aeiou//%2==0?"True":"False" for(@ARGV)
