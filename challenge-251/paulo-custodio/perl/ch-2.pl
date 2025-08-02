#!/usr/bin/env perl

# Challenge 251
#
# Task 2: Lucky Numbers
# Submitted by: Mohammad S Anwar
#
# You are given a m x n matrix of distinct numbers.
#
# Write a script to return the lucky number, if there is one, or -1 if not.
#
# A lucky number is an element of the matrix such that it is
# the minimum element in its row and maximum in its column.
#
#
# Example 1
#
# Input: $matrix = [ [ 3,  7,  8],
#                    [ 9, 11, 13],
#                    [15, 16, 17] ];
# Output: 15
#
# 15 is the only lucky number since it is the minimum in its row
# and the maximum in its column.
#
# Example 2
#
# Input: $matrix = [ [ 1, 10,  4,  2],
#                    [ 9,  3,  8,  7],
#                    [15, 16, 17, 12] ];
# Output: 12
#
# Example 3
#
# Input: $matrix = [ [7 ,8],
#                    [1 ,2] ];
# Output: 7

use Modern::Perl;

my @matrix = parse_matrix("@ARGV");
say lucky_number(@matrix);

sub parse_matrix {
    my($input) = @_;
    my @matrix;
    $input =~ s/^\s*\[\s*//s or die "missing starting [ in '$input'";
    $input =~ s/\s*\]\s*$//s or die "missing ending ] in '$input'";
    $input =~ s/^\s+//s;
    while ($input ne '') {
        ($input, my @row) = parse_row($input);
        push @matrix, \@row;
        $input =~ s/^\s*,?\s*//s;
    }
    return @matrix;
}

sub parse_row {
    my($input) = @_;
    $input =~ s/^\s*\[\s*//s or die "missing starting [ in '$input'";
    (my $row, $input) = $input =~ /(.*?)\]\s*(.*)/s or die die "missing ending ] in '$input'";
    my @row = split(/(?:\s|,)+/, $row);
    return ($input, @row);
}

sub lucky_number {
    my(@matrix) = @_;
    for my $r (0 .. $#matrix) {
        my $row = $matrix[$r];
        my $c = min_col_in_row(@$row);
        my $max_r = max_row_in_col($c, @matrix);
        if ($r == $max_r) {
            return $matrix[$r][$c];
        }
    }
    return -1;
}

sub min_col_in_row {
    my(@row) = @_;
    my $min_c = 0;
    for my $c (0 .. $#row) {
        if ($row[$c] < $row[$min_c]) {
            $min_c = $c;
        }
    }
    return $min_c;
}

sub max_row_in_col {
    my($c, @matrix) = @_;
    my $max_r = 0;
    for my $r (0 .. $#matrix) {
        if ($matrix[$r][$c] > $matrix[$max_r][$c]) {
            $max_r = $r;
        }
    }
    return $max_r;
}
