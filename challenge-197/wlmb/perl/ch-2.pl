#!/usr/bin/env perl
# Perl weekly challenge 197
# Task 2:  Wiggle Sort
#
# See https://wlmb.github.io/2022/12/26/PWC197/#task-2-wiggle-sort
use v5.36;
use List::MoreUtils qw(any pairwise slide);
say(<<~"FIN"), exit unless @ARGV;
    Usage: $0 N1 [N2...]
    to wiggle sort the numbers N1 N2...
    FIN
my @high=sort {$a <=> $b} @ARGV;
my @low=reverse splice @high, 0, (@high+1)/2;
@high=reverse @high;
my $prev;
my @out = grep {defined $_} pairwise {($a, $b)} @low, @high;
my $failed=any {$_} slide {$a == $b} @out;
say join " ", @ARGV, "->", $failed?"No solution":@out;
