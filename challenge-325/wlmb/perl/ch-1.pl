#!/usr/bin/env perl
# Perl weekly challenge 325
# Task 1:  Consecutive One
#
# See https://wlmb.github.io/2025/06/09/PWC325/#task-1-consecutive-one
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 B1 B2...
    to find the largest run of 1's among the bits B1 B2...
    FIN
my $current=0;
my $max=0;
for(@ARGV){
    $current=0, next if $_==0;
    ++$current, ($max<$current)&&($max=$current), next if $_==1;
    die "Only 0's and 1's allowed: $_";
}
say "@ARGV -> $max";
