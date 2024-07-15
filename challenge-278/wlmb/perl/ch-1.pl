#!/usr/bin/env perl
# Perl weekly challenge 278
# Task 1:  Sort String
#
# See https://wlmb.github.io/2024/07/15/PWC278/#task-1-sort-string
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    Sort the strings S1 S2...
    Each string is formed of space-separated word-number strings, i.e., a word concatenated to a
    non-negative number giving its position.
    FIN
for(@ARGV){
    my @pair_strings=split " ", $_;
    my @pairs;
    for(@pair_strings){
	/^(.+)?([0-9]+)$/ or die "Expected WD where W are word characters and D are digits: $_";
	push @pairs, [$1, $2];
    }
    my @sorted=map {$_->[0]} sort {$a->[1] <=> $b->[1] || lc $a->[0] cmp lc $b->[0]} @pairs;
    say "$_ -> @sorted";
}
