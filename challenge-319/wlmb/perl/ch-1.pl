#!/usr/bin/env perl
# Perl weekly challenge 319
# Task 1:  Word Count
#
# See https://wlmb.github.io/2025/04/28/PWC319/#task-1-word-count
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 W2...
    to count how many of the words Wn start or end in a vowel.
    FIN
my $vowels="[aeiou]";
my $re=qr/(^$vowels)|($vowels$)/;
my $result = 0 + grep{/$re/} @ARGV;
say "@ARGV -> $result";
