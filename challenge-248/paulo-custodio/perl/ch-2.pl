#!/usr/bin/env perl

# Challenge 248
#
# Task 2: Submatrix Sum
# Submitted by: Jorg Sommrey
# You are given a NxM matrix A of integers.
#
# Write a script to construct a (N-1)x(M-1) matrix B having elements that are the sum over the 2x2 submatrices of A,
#
# b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]
#
# Example 1
# Input: $a = [
#               [1,  2,  3,  4],
#               [5,  6,  7,  8],
#               [9, 10, 11, 12]
#             ]
#
# Output: $b = [
#                [14, 18, 22],
#                [30, 34, 38]
#              ]
# Example 2
# Input: $a = [
#               [1, 0, 0, 0],
#               [0, 1, 0, 0],
#               [0, 0, 1, 0],
#               [0, 0, 0, 1]
#             ]
#
# Output: $b = [
#                [2, 1, 0],
#                [1, 2, 1],
#                [0, 1, 2]
#              ]

use Modern::Perl;

my $matrix = parse_matrix("@ARGV");
my $sums = sum_submatrices($matrix);
print_matrix($sums);

sub parse_matrix {
    my($text) = @_;
    my @lines = split(/\]\s*,/, $text);
    my $matrix = [];
    for (@lines) {
        s/^\D+//;
        my @nums = split /\D+/, $_;
        push @$matrix, \@nums;
    }
    return $matrix;
}

sub sum_submatrices {
    my($matrix) = @_;
    my $sums = [];
    my $rows = scalar(@$matrix);
    my $cols = scalar(@{$matrix->[0]});
    for my $r (0 .. $rows-2) {
        for my $c (0 .. $cols-2) {
            $sums->[$r][$c] = 0;
            $sums->[$r][$c] += $matrix->[$r][$c];
            $sums->[$r][$c] += $matrix->[$r][$c+1];
            $sums->[$r][$c] += $matrix->[$r+1][$c];
            $sums->[$r][$c] += $matrix->[$r+1][$c+1];
        }
    }
    return $sums;
}

sub print_matrix {
    my($matrix) = @_;
    say "[";
    for (@$matrix) {
        say "  [", join(", ", @$_), "],";
    }
    say "]";
}
