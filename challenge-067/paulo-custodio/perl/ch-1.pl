#!/usr/bin/env perl

# Challenge 067
#
# TASK #1 › Number Combinations
# Submitted by: Mohammad S Anwar
#
# You are given two integers $m and $n. Write a script print all possible
# combinations of $n numbers from the list 1 2 3 … $m.
#
# Every combination should be sorted i.e. [2,3] is valid combination but [3,2] is not.
#
# Example:
#   Input: $m = 5, $n = 2
#
#   Output: [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]

use Modern::Perl;
use Math::Combinatorics 'combine';

my($m, $n) = @ARGV;
my @m = (1..$m);
my %out;
for (combine($n, @m)) {
    $out{"[".join(",", sort @$_)."]"} = 1;
}
say "[ ", join(", ", sort keys %out), " ]";
