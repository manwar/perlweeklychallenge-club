#!/usr/bin/env perl
# Perl weekly challenge 373
# Task 1:  Equal List
#
# See https://wlmb.github.io/2026/05/11/PWC373/#task-1-equal-list
use v5.36;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S0a S0b S1a S1b ...
    to compare the set of comma separated strings Sna with Snb.
    FIN

for my($x,$y)(@ARGV){
    say "$x; $y -> ", join_split($x) eq join_split($y)? "True":"False";
}

sub join_split($x){
    join "", split /\s*,\s*/, $x
}
