#!/usr/bin/env perl
# Perl weekly challenge 234
# Task 2:  Unequal Triplets
#
# See https://wlmb.github.io/2023/09/11/PWC234/#task-2-unequal-triplets
use v5.36;
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum0 product);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to count the number of unequal triplets in the set {N1 N2...}
    FIN
my %count_for_number;
++$count_for_number{$_} for @ARGV;
my @numbers=keys %count_for_number;
my $result=@numbers<3
    ? 0
    : sum0 map {
	product @count_for_number{@$_}
} combinations(\@numbers,3);
say "@ARGV -> $result",
