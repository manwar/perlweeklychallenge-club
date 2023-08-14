#!/usr/bin/env perl
# Perl weekly challenge 229
# Task 2:  Two out of Three
#
# See https://wlmb.github.io/2023/08/06/PWC229/#task-2-two-out-of-three
use v5.36;
use List::Util qw(uniq);
die <<~"FIN" unless @ARGV>=3;
    Usage: $0 A1 A2 A3 [A4...]
    to find which elements of the arrays A1, A2... are common to two or more arrays.
    Each array is a string with space separated elements.
    More than three input arrays are allowed.
    input array
    FIN
my %count;
for(@ARGV){
    $count{$_}++ for uniq split " ";
}
my @output=sort {$a <=> $b} grep {$count{$_}>=2} keys %count;
say map({"[$_]"} @ARGV), "->[@output]"
