#!/usr/bin/env perl
# Perl weekly challenge 301
# Task 2:  Hamming Distance
#
# See https://wlmb.github.io/2024/12/23/PWC301/#task-2-hamming-distance
use v5.36;
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find the sum of the  Hamming distances between all pairs of
    numbers taken from the list N1 N2...
    FIN
say "@ARGV -> ",               # read the following comments upwards
    sum                        # sum them
    map {                      # get Hamming distance for each pair
	sum                    # sum them
	    split "",          # separate binary digits
	    sprintf "%b",      # convert to binary
	    $_->[0]^$_->[1]    # exclusive or -> 1 when bits differ, 0 when they are equal
} combinations(\@ARGV,2);      # generate all pairs of numbers
