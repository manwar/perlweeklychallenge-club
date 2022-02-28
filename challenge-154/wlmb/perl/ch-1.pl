#!/usr/bin/env perl
# Perl weekly challenge 154
# Task 1: Missing permutation
#
# See https://wlmb.github.io/2022/02/28/PWC154/#task-1-missing-permutation
use v5.12;
use warnings;
use Algorithm::Combinatorics qw(permutations);
use Text::Wrap qw(wrap $columns $break);

die "Usage: ./ch-1.pl W1 W2 W3...\n where Wn are permutations of a word\n"
    ."to generate the missing permutations" unless @ARGV;
my @seen=@ARGV;
my $first=$seen[0];
my @letters=split "", $first;
my %seen;
map {$seen{$_}=1} @seen;
my %permutations; # all permutations
$permutations{$_}=1 for map {join "", @$_} permutations(\@letters);
# Check the input
map {die "$_ is not a permutation of $first" unless $permutations{$_}} keys %seen;
$columns=62; $break=qr/\s/;
say wrap("", "    ", "Input: ", join ", ", @seen);
say wrap("", "    ", "Missing permutations: ", join ", ",
                     grep {!$seen{$_}} keys %permutations);
