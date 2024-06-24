#!/usr/bin/env perl
# Perl weekly challenge 275
# Task 1:  Broken Keys
#
# See https://wlmb.github.io/2024/06/24/PWC275/#task-1-broken-keys
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 "S" K1 K2...
    to count how many words in the sentence S don't contain the broken keys K1 K2...
    FIN
my ($sentence, @keys)=@ARGV;
my @words=split " ",$sentence;
say "sentence: \"$sentence\" keys: @keys -> ", 0+grep{!/[@keys]/i}@words;
