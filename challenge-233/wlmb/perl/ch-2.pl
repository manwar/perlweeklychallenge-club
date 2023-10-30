#!/usr/bin/env perl
# Perl weekly challenge 233
# Task 2:  Frequency Sort
#
# See https://wlmb.github.io/2023/09/04/PWC233/#task-2-frequency-sort
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to sort the numbers Ni according to their frequencies (increasing)
    and their values (decreasing).
    FIN
my %count;
$count{$_}++ for @ARGV;
my @sorted=sort {$count{$a} <=> $count{$b} || $b <=> $a} @ARGV;
say "@ARGV -> @sorted";
