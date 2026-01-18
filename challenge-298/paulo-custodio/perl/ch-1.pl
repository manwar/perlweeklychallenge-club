#!/usr/bin/env perl

# Challenge 298
#
# Task 1: Maximal Square
# Submitted by: Mohammad Sajid Anwar
# You are given an m x n binary matrix with 0 and 1 only.
#
# Write a script to find the largest square containing only 1's and return it’s area.
#
# Example 1
# Input: @matrix = ([1, 0, 1, 0, 0],
#                   [1, 0, 1, 1, 1],
#                   [1, 1, 1, 1, 1],
#                   [1, 0, 0, 1, 0])
# Output: 4
#
# Two maximal square found with same size marked as 'x':
#
# [1, 0, 1, 0, 0]
# [1, 0, x, x, 1]
# [1, 1, x, x, 1]
# [1, 0, 0, 1, 0]
#
# [1, 0, 1, 0, 0]
# [1, 0, 1, x, x]
# [1, 1, 1, x, x]
# [1, 0, 0, 1, 0]
# Example 2
# Input: @matrix = ([0, 1],
#                   [1, 0])
# Output: 1
#
# Two maximal square found with same size marked as 'x':
#
# [0, x]
# [1, 0]
#
#
# [0, 1]
# [x, 0]
# Example 3
# Input: @matrix = ([0])
# Output: 0

use Modern::Perl;
use List::Util qw(min max);

my @m = parse_input();
say max_area(@m);

sub parse_input {
    my @m;
    while (<>) {
        my @r = split ' ', $_;
        push @m, \@r;
    }
    return @m;
}

sub max_area {
    my(@m) = @_;
    my $max_area = 0;
    for my $r1 (0 .. $#m) {
        for my $c1 (0 .. $#{$m[0]}) {
            next if $m[$r1][$c1] == 0;
            for my $w (0 .. min($#m-$r1, $#{$m[0]}-$c1)) {
                my($r2, $c2) = ($r1+$w, $c1+$w);
                next if $m[$r2][$c2] == 0;
                my $area = compute_area(\@m, $r1, $c1, $r2, $c2);
                $max_area = max($area, $max_area);
            }
        }
    }
    return $max_area;
}

sub compute_area {
    my($m, $r1, $c1, $r2, $c2) = @_;
    for my $r ($r1 .. $r2) {
        for my $c ($c1 .. $c2) {
            return 0 if $m->[$r][$c] == 0;
        }
    }
    return ($r2-$r1+1)*($c2-$c1+1);
}
