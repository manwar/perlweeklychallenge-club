#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use List::Util qw(sum);
use Algorithm::Combinatorics qw(subsets);

# TASK #1 › Fibonacci Sum
# Submitted by: Mohammad S Anwar
#
# You are given a positive integer $N.
# UPDATE: 2020-09-07 09:00:00
#
# Write a script to find out all possible combination of Fibonacci
# Numbers required to get $N on addition.
#
# You are NOT allowed to repeat a number. Print 0 if none found.
# Example 1:
#
# Input: $N = 6
#
# Output:
#     1 + 2 + 3 = 6
#     1 + 5 = 6
#
# Example 2:
#
# Input: $N = 9
#
# Output:
#     1 + 8 = 9
#     1 + 3 + 5 = 9

sub fibs_upto($n) {
    if ($n == 1) {
        return (1);
    } else {
        my @fibs = (1,2);
        while (1) {
            my $next = $fibs[-2] + $fibs[-1];
            if ($next <= $n) {
                push @fibs, $next;
            } else {
                return @fibs;
            }
        }
    }
}

my $n = $ARGV[0];
my @fibs = fibs_upto($n);
my $iter = subsets(\@fibs);
my $found = 0;
while (my $p = $iter->next) {
    next unless $p->@*;
    local $, = ' + ';
    if (sum($p->@*) == $n) {
        say $p->@*;
        $found = 1;
    }
}

say 0 unless $found;

