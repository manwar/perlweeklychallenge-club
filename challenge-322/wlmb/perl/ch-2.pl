#!/usr/bin/env perl
# Perl weekly challenge 322
# Task 2:  Rank Array
#
# See https://wlmb.github.io/2025/05/19/PWC322/#task-2-rank-array
use v5.36;
use List::Util qw(uniq);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find the ranks Ri of the numbers Ni
    FIN
my %rank;
my $current=0;
$rank{$_}=++$current for sort {$a<=>$b} uniq @ARGV;
say "@ARGV -> @rank{@ARGV}";
