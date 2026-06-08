#!/usr/bin/env perl
# Perl weekly challenge 377
# Task 2:  Prefix Suffix
#
# See https://wlmb.github.io/2026/06/08/PWC377/#task-2-prefix-suffix
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 A0 A1...
    to find in how many pairs of space-separated substrings of the string An
    are the first is both prefix and suffix of the second.
    FIN

for(@ARGV){
    my @strings = split" ";
    my $count = 0;
    for my $str1(@strings){
	/^$str1/ && /$str1$/ && ++$count for @strings
    };
    say"$_ -> ", $count - @strings;
}
