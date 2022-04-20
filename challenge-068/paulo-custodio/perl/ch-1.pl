#!/usr/bin/env perl

# Challenge 068
#
# TASK #1 › Zero Matrix
# Submitted by: Mohammad S Anwar
# You are given a matrix of size M x N having only 0s and 1s.
#
# Write a script to set the entire row and column to 0 if an element is 0.
#
# Example 1
# Input: [1, 0, 1]
#        [1, 1, 1]
#        [1, 1, 1]
#
# Output: [0, 0, 0]
#         [1, 0, 1]
#         [1, 0, 1]
# Example 2
# Input: [1, 0, 1]
#        [1, 1, 1]
#        [1, 0, 1]
#
# Output: [0, 0, 0]
#         [1, 0, 1]
#         [0, 0, 0]

use Modern::Perl;
use Clone 'clone';
use Test::More;

is_deeply [zero_matrix([1,0,1],
                       [1,1,1],
                       [1,1,1])],
    [[0,0,0],
     [1,0,1],
     [1,0,1]];

is_deeply [zero_matrix([1,0,1],
                       [1,1,1],
                       [1,0,1])],
    [[0,0,0],
     [1,0,1],
     [0,0,0]];

done_testing;


sub zero_matrix {
    my(@m) = @_;
    my $orig = clone(\@m);
    for my $r (0 .. @m-1) {
        for my $c (0 .. @{$m[0]}-1) {
            if (!$orig->[$r][$c]) {
                @m = zero_row($r, @m);
                @m = zero_col($c, @m);
            }
        }
    }
    return @m;
}

sub zero_row {
    my($r, @m) = @_;
    for my $c (0 .. @{$m[0]}-1) {
        $m[$r][$c] = 0;
    }
    return @m;
}

sub zero_col {
    my($c, @m) = @_;
    for my $r (0 .. @m-1) {
        $m[$r][$c] = 0;
    }
    return @m;
}
