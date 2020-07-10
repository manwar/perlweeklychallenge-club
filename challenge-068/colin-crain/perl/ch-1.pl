#! /opt/local/bin/perl
#
#       zip-zilch-zero.pl
#
#         TASK #1 › Zero Matrix
#         Submitted by: Mohammad S Anwar
#         You are given a matrix of size M x N having only 0s and 1s.
#
#         Write a script to set the entire row and column to 0 if an
#         element is 0.
#
#         Example 1
#             Input:  [1, 0, 1]
#                     [1, 1, 1]
#                     [1, 1, 1]
#
#             Output: [0, 0, 0]
#                     [1, 0, 1]
#                     [1, 0, 1]
#         Example 2
#             Input:  [1, 0, 1]
#                     [1, 1, 1]
#                     [1, 0, 1]
#
#             Output: [0, 0, 0]
#                     [1, 0, 1]
#                     [0, 0, 0]
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

## as by challenge definition we only use 1s and 0s,
## concatenate individual rows into strings
## example: 101 111 111 001
my @matrix;
push @matrix, map { [ split //, $_ ] } @ARGV;
my $rows = @matrix;
my $cols = $matrix[0]->@*;

print_matrix(\@matrix, "Input:");

## 0s are considered 'opaque' -- a single 0 occludes the entire row or column
## We pass once through the matrix, row by row, recording the 0 occurence data to
## two arrays, one for rows, the other columns
my @row_zeros = (0) x $rows;
my @col_zeros = (0) x $cols;

for my $row_idx (0..$rows-1) {
    my $sum = 0;
    for my $col_idx ( 0..$cols-1) {
        $sum += $matrix[$row_idx]->[$col_idx];
        $col_zeros[$col_idx] |= ! $matrix[$row_idx]->[$col_idx];
    }
    $row_zeros[$row_idx] = 1 if $sum != $cols;
}

say<<__END__;

Zero Occlusions:
    cols: @col_zeros
    rows: @row_zeros
__END__

## now we can pass through the matrix again, transferring the occurence
## data back to the rows and columns, zeroing them out as specified
for my $row_idx (0..$rows-1) {
    if ($row_zeros[$row_idx] == 1) {
        $matrix[$row_idx] = [ (0) x $cols ];
        next;
    }
    for my $col_idx ( 0..$cols-1) {
        $matrix[$row_idx]->[$col_idx] = 0 if $col_zeros[$col_idx] == 1;
    }
}

print_matrix(\@matrix, "Output:");

## ## ## ## ## SUBS:

sub print_matrix {
    my ($matrix, $heading ) = @_;
    say "$heading";
    for ($matrix->@*) {
        say "\t[ ", (join ', ', $_->@*), " ]";
    }
}
