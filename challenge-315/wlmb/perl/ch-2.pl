#!/usr/bin/env perl
# Perl weekly challenge 315
# Task 2:  Find Third
#
# See https://wlmb.github.io/2025/03/31/PWC315/#task-2-find-third
use v5.36;
die <<~"FIN" unless @ARGV==3;
    Usage: W1 W2 S
    to find which words in sentence S follows words W1 and W2.
    FIN
my ($first, $second, $sentence)=@ARGV;
for($first, $second){die "Expected a single word: $_" unless /^\w+$/}
my $re="$first\\W+(*pla:$second\\W+(\\w+))";
my @output=$sentence=~/$re/g;
say "first: $first, second: $second, \nsentence: $sentence\n-> @output"
