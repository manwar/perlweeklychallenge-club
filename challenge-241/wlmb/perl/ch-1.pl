#!/usr/bin/env perl
# Perl weekly challenge 241
# Task 1:  Arithmetic Triplets
#
# See https://wlmb.github.io/2023/10/30/PWC241/#task-1-arithmetic-triplets
use v5.36;
use List::Util qw(all);
use Algorithm::Combinatorics qw(combinations);
die <<~"FIN" if @ARGV<2;
    Usage: $0 D N0 [N1...]
    to count the triplets taken from N0 N1... with difference D between succesive terms;
    FIN
my $diff=shift;
my @sorted=sort {$a <=> $b} @ARGV;
die "Array should be ordered" unless all {$sorted[$_]==$ARGV[$_]} 0..@ARGV-1;
say "Nums: @sorted, diff: $diff -> ",
    0+grep{$_->[1]-$_->[0]==$_->[2]-$_->[1]==$diff} combinations([@sorted],3)
