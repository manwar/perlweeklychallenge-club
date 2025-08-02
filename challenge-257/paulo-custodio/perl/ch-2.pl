#!/usr/bin/env perl

# Challenge 257
#
# Task 2: Reduced Row Echelon
# Submitted by: Ali Moradi
# Given a matrix M, check whether the matrix is in reduced row echelon form.
#
# A matrix must have the following properties to be in reduced row echelon form:
#
# 1. If a row does not consist entirely of zeros, then the first
#    nonzero number in the row is a 1. We call this the leading 1.
# 2. If there are any rows that consist entirely of zeros, then
#    they are grouped together at the bottom of the matrix.
# 3. In any two successive rows that do not consist entirely of zeros,
#    the leading 1 in the lower row occurs farther to the right than
#    the leading 1 in the higher row.
# 4. Each column that contains a leading 1 has zeros everywhere else
#    in that column.
# For example:
#
# [
#    [1,0,0,1],
#    [0,1,0,2],
#    [0,0,1,3]
# ]
# The above matrix is in reduced row echelon form since the first nonzero number
# in each row is a 1, leading 1s in each successive row are farther to the right,
# and above and below each leading 1 there are only zeros.
#
# For more information check out this wikipedia article.
#
# Example 1
#     Input: $M = [
#                   [1, 1, 0],
#                   [0, 1, 0],
#                   [0, 0, 0]
#                 ]
#     Output: 0
# Example 2
#     Input: $M = [
#                   [0, 1,-2, 0, 1],
#                   [0, 0, 0, 1, 3],
#                   [0, 0, 0, 0, 0],
#                   [0, 0, 0, 0, 0]
#                 ]
#     Output: 1
# Example 3
#     Input: $M = [
#                   [1, 0, 0, 4],
#                   [0, 1, 0, 7],
#                   [0, 0, 1,-1]
#                 ]
#     Output: 1
# Example 4
#     Input: $M = [
#                   [0, 1,-2, 0, 1],
#                   [0, 0, 0, 0, 0],
#                   [0, 0, 0, 1, 3],
#                   [0, 0, 0, 0, 0]
#                 ]
#     Output: 0
# Example 5
#     Input: $M = [
#                   [0, 1, 0],
#                   [1, 0, 0],
#                   [0, 0, 0]
#                 ]
#     Output: 0
# Example 6
#     Input: $M = [
#                   [4, 0, 0, 0],
#                   [0, 1, 0, 7],
#                   [0, 0, 1,-1]
#                 ]
#     Output: 0

use Modern::Perl;

my $matrix = parse_matrix("@ARGV");
say is_reduced_row_echelon($matrix);

sub parse_matrix {
    my($text) = @_;
    my @lines = split(/\]\s*,/, $text);
    my $matrix = [];
    for (@lines) {
        s/^[^-0-9]+//;
        my @nums = split /[^-0-9]+/, $_;
        push @$matrix, \@nums;
    }
    return $matrix;
}

sub is_reduced_row_echelon {
    my($matrix) = @_;
    my @matrix = @$matrix;

    @matrix = move_zero_rows_to_end(@matrix);

    # leading 1 is indented
    my $last_one_col = -1;
    for (@matrix) {
        my @row = @$_;
        my $col = first_non_zero_col(@row);
        if ($col >= 0) {
            if ($row[$col] != 1) {
                return 0;
            }
            elsif ($col <= $last_one_col) {
                return 0;
            }
            else {
                $last_one_col = $col;
            }
        }
    }

    # column of leading one is all zeros
    for my $row (0 .. $#matrix) {
        my @row = @{$matrix[$row]};
        my $col = first_non_zero_col(@row);
        if ($col >= 0) {
            for my $zero_row (0 .. $row-1, $row+1 .. $#matrix) {
                if ($matrix[$zero_row][$col] != 0) {
                    return 0;
                }
            }
        }
    }

    return 1;
}

sub move_zero_rows_to_end {
    my(@matrix) = @_;

    my @new_matrix;
    my @zeros;
    for (@matrix) {
        my @row = @$_;
        if (is_zero_row(@row)) {
            push @zeros, \@row;
        }
        else {
            push @new_matrix, \@row;
        }
    }
    @matrix = (@new_matrix, @zeros);
    return @matrix;
}

sub first_non_zero_col {
    my(@row) = @_;
    my $col = 0;
    while ($col < @row && $row[$col] == 0) {
        $col++;
    }
    if ($col == scalar(@row)) {
        return -1;
    }
    else {
        return $col;
    }
}

sub is_zero_row {
    my(@row) = @_;
    return first_non_zero_col(@row) == -1;
}
