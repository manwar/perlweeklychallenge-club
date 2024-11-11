#!/usr/bin/env perl
# Perl weekly challenge 295
# Task 1:  Word Break
#
# See https://wlmb.github.io/2024/11/11/PWC295/#task-1-word-break
use v5.36;
die <<~"FIN" unless @ARGV>=2;
    Usage: $0 S W1 W2...
    to find if string can be separated into one or more of the words
    from the list W1 W2...
    FIN
my ($string, @words)=@ARGV;
my $words=join '|', @words;
say "String: $string, words: @words -> ", $string=~/^(\s*$words\s*)*$/?"True":"False";
