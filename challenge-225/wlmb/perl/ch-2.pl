#!/usr/bin/env perl
# Perl weekly challenge 225
# Task 2:  Left Right Sum Diff
#
# See https://wlmb.github.io/2023/07/09/PWC225/#task-2-left-right-sum-diff
use v5.36;
use List::Util qw(reductions);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find the differences of the right and left sums of the list of
    numbers N1 N2...
    FIN
my @input= (0, @ARGV, 0);
my $last_index=@input-3;
my ($left, $right) = map {[reductions {$a+$b} @$_]}
    [@input[0..$last_index]], [((reverse @input)[0..$last_index])];
my @output = map {abs($left->[$_] - $right->[-$_-1])} 0..$last_index;
say "@ARGV -> @output";
