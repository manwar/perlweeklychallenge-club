#!/usr/bin/env perl
# Perl weekly challenge 385
# Task 1:  Uncommon Words
#
# See https://wlmb.github.io/2026/08/03/PWC385/#task-1-uncommon-words
use v5.36;
die <<~"FIN" unless @ARGV && @ARGV %2 == 0;
    Usage: $0 X0 Y0 X1 Y1...
    to find non-repeated words in the strings Xn and Yn.
    FIN
for my($sentence1, $sentence2)(@ARGV){
    my %count;
    ++$count{$_} for split" ","$sentence1 $sentence2";
    my @out = grep{$count{$_}==1} keys %count;
    say "$sentence1; $sentence2 -> (@out)";
}
