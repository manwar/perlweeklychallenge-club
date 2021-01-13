#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use Algorithm::Combinatorics qw(combinations);

# TASK #1 › Number Combinations
# Submitted by: Mohammad S Anwar
#
# You are given two integers $m and $n. Write a script print all
# possible combinations of $n numbers from the list 1 2 3 … $m.
#
# Every combination should be sorted i.e. [2,3] is valid combination
# but [3,2] is not.  Example:
#
#   Input: $m = 5, $n = 2
#
#   Output: [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]
#
# Solution: This is straightforward with combinations() from
# Algorithm::Combinatorics

my ($m, $n) = @ARGV;

my @data = 1..$m;
my @combs;
my $iter = combinations(\@data, $n);
while (my $p = $iter->next) {
    push @combs, sprintf('[%s]', join(',', $p->@*));
}
say '[ ', join(", ", @combs), ' ]';
