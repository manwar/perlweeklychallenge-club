#!/usr/bin/env perl
# Perl weekly challenge 226
# Task 2:  Zero Array
#
# See https://wlmb.github.io/2023/07/16/PWC226/#task-2-zero-array
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 [N1 ...]
    to find how many cycles are required to zero the array N0 N1...
    FIN
my @sorted = grep {$_} sort {$a <=> $b} my @in=@ARGV;
my $count=0;
while(@sorted){
    ++$count;
    my $first=shift @sorted;
    $sorted[$_]-=$first for 0..@sorted-1;
    shift @sorted while @sorted and $sorted[0]==0;
}
say "@in -> $count";
