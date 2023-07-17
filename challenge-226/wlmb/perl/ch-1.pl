#!/usr/bin/env perl
# Perl weekly challenge 226
# Task 1:  Shuffle String
#
# See https://wlmb.github.io/2023/07/16/PWC226/#task-1-shuffle-string
use v5.36;
die <<~"FIN" unless @ARGV >= 2;
    Usage: $0 string p0 [p1.. ]
    to reorder string sending its first character to position
    p0 in output, the second to p1 and so on
    FIN
my $in = shift;           # input string
my @in = split "", $in;   # as array of characters
die "Can't have more positions than input characters" unless @ARGV <= @in;
my @out;                  # output characters
$out[$_] = shift @in for @ARGV; # copy input to output array
my $out = join "", @out;
say "$in @ARGV -> $out";
