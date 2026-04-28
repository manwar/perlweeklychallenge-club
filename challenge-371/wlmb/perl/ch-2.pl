#!/usr/bin/env perl
# Perl weekly challenge 371
# Task 2:  Subset Equilibrium
#
# See https://wlmb.github.io/2026/04/27/PWC371/#task-2-subset-equilibrium
use v5.36;
use feature qw(try);
use Algorithm::Combinatorics qw(subsets);
use List::Util qw(all sum);
use Scalar::Util qw(looks_like_number);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the subsets of the space separated sets of numbers
    Sn whose sum equal the sum of their indices (one-based).
    FIN
for(@ARGV){
    try {
        my @numbers = split " ";
        die "Expected space separated numbers: $_"
            unless all {looks_like_number $_} @numbers;
        my @indices = 0..@numbers-1;
        my @results = map{
            "[@numbers[@$_]]"
        } grep {
            1 < @$_ < @numbers                  #check length of subset
            && sum(@$_)+@$_== sum @numbers[@$_] # check sums
        }
        subsets(\@indices);
        say"$_ -> [ @results ]";
    }
    catch($e){ warn $e; }
}
