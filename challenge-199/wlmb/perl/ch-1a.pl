#!/usr/bin/env perl
# Perl weekly challenge 199
# Task 1:  Good Pairs. Calculating number of pairs for each distinct value .
#
# See https://wlmb.github.io/2023/01/09/PWC199/#task-1-good-pairs
use v5.36;
use List::Util qw(sum);
use List::MoreUtils qw(frequency);
say(<<~"FIN"), exit unless @ARGV >= 2;
    Usage: $0 N1 N2 [N3...]
    to find all good pairs from the set N1 N2...
    FIN
my %histogram=frequency @ARGV; # pairs of value=>repetitions
my @counts=values %histogram;
my @number_of_pairs=map {$_*($_-1)/2} @counts;
say join " ", @ARGV, "->", sum @number_of_pairs;
