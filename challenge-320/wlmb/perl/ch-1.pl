#!/usr/bin/env perl
# Perl weekly challenge 320
# Task 1:  Maximum Count
#
# See https://wlmb.github.io/2025/05/05/PWC320/#task-1-maximum-count
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find the maximum between the count of positive
    and negative numbers among N1 N2...
    FIN
my ($positive, $negative)=(0, 0);
for(@ARGV){
    ++$positive if $_>0;
    ++$negative if $_<0;
}
say "@ARGV -> ",max($negative, $positive);
