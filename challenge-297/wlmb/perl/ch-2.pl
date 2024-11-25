#!/usr/bin/env perl
# Perl weekly challenge 297
# Task 2:  Semi-Ordered Permutation
#
# See https://wlmb.github.io/2024/11/25/PWC297/#task-2-semi-ordered-permutation
use v5.36;
use List::AllUtils qw(minmax_by);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to count permutations needed for the list (N0 N1...) to become
    semiordered.
    FIN
my ($min_index, $max_index) = minmax_by {$ARGV[$_]} 0..@ARGV-1;
my $result = $min_index + @ARGV -1 - $max_index -
             ($max_index < $min_index);
say "@ARGV -> $result";
