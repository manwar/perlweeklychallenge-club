#!/usr/bin/env perl
# Perl weekly challenge 307
# Task 1:  Check Order
#
# See https://wlmb.github.io/2025/02/02/PWC307/#task-1-check-order
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find the indices where the array N0 N1... differs from its ordered self.
    FIN
my @ordered = sort {$a <=> $b} @ARGV;
my @result;
$ordered[$_]!=$ARGV[$_] && push @result, $_ for 0..@ordered-1;
say "@ARGV -> @result";
