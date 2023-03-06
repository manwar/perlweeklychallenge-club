#!/usr/bin/env perl
# Perl weekly challenge 206
# Task 2:  Array Pairings
#
# See https://wlmb.github.io/2023/02/27/PWC206/#task-2-array-pairings
use v5.36;
use List::Util qw(sum);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 N1 N2 [N3 N4...]
    to find the maximum of the sum of the minima of each pair (Ni, Nj)
    taken over all possible pairings. The number of arguments should be even.
    FIN
my $i = 0; # counter
my $max = sum          # sum
    map {$i++%2?():$_} # every second element
    sort {$a<=>$b}     # of the sorted (ascending)
    @ARGV;             # input
say join " ", @ARGV, "->", $max;
