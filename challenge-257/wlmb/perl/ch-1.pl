#!/usr/bin/env perl
# Perl weekly challenge 257
# Task 1:  Smaller than Current
#
# See https://wlmb.github.io/2024/02/20/PWC257/#task-1-smaller-than-current
use v5.36;
use List::Util qw(uniq);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to count how many numbers Nj are smaller than Ni
    FIN
my @sorted=sort {$a<=>$b} uniq @ARGV;
my %count;
$count{$sorted[$_]}=$_ for 0..@sorted-1;
say "@ARGV -> @count{@ARGV}";
