#!/usr/bin/env perl
# Perl weekly challenge 263
# Task 1:  Target Index
#
# See https://wlmb.github.io/2024/04/01/PWC263/#task-1-target-index
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 k N0 [N1...]
    to find the indices of the array N0 N1... (after sorting) for which
    N_i=k
    FIN
my $k=shift;
my @sorted=sort{$a<=>$b}@ARGV;
say "k=$k, ints=(@ARGV) -> ",
    join " ", "(", grep({$sorted[$_]==$k} (0..@sorted-1)), ")";
