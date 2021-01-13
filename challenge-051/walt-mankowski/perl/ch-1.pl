#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);

# 3 Sum
# Given an array @Lof integers. Write a script to find all unique
# triplets such that a + b + c is same as the given target T. Also
# make sure a <= b <= c.
#
# Here is wiki page for more information:
# https://en.wikipedia.org/wiki/3SUM
#
# Example:
#
# @L = (-25, -10, -7, -3, 2, 4, 8, 10);
#
# One such triplet for target 0 i.e. -10 + 2 + 8 = 0.

my @L = (-25, -10, -7, -3, 2, 4, 8, 10);
@L = sort {$a <=> $b} @L;
my $target = 0;
my $iter = combinations(\@L, 3);
while (my $p = $iter->next) {
    say prettyprint($p, $target) if sum(@$p) == $target;
}

sub prettyprint($p, $target) {
    my $s = $p->[0];
    for my $i (1..$#$p) {
        $s .= $p->[$i] >= 0 ? ' + ' : ' - ';
        $s .= abs($p->[$i]);
    }
    $s .= " = $target";
    return $s;
}
