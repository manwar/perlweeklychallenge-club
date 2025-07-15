#!/usr/bin/env perl
# Perl weekly challenge 330
# Task 2:  Title Capital
#
# See https://wlmb.github.io/2025/07/14/PWC330/#task-2-title-capital
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to convert words in the space-separated strings Sn to titlecase
    or to lowercase if their length exceeds or not 2 characters.
    FIN
say join " ", map {(length($_) >2 && ucfirst)||$_} split " ", lc for @ARGV;
