#!/usr/bin/env perl

# Challenge 111
#
# TASK #1 - Search Matrix
# Submitted by: Mohammad S Anwar
# You are given 5x5 matrix filled with integers such that each row is sorted
# from left to right and the first integer of each row is greater than the
# last integer of the previous row.
#
# Write a script to find a given integer in the matrix using an efficient
# search algorithm.
#
# Example
#     Matrix: [  1,  2,  3,  5,  7 ]
#             [  9, 11, 15, 19, 20 ]
#             [ 23, 24, 25, 29, 31 ]
#             [ 32, 33, 39, 40, 42 ]
#             [ 45, 47, 48, 49, 50 ]
#
#     Input: 35
#     Output: 0 since it is missing in the matrix
#
#     Input: 39
#     Output: 1 as it exists in the matrix

use Modern::Perl;

my @data = ([  1,  2,  3,  5,  7 ],
            [  9, 11, 15, 19, 20 ],
            [ 23, 24, 25, 29, 31 ],
            [ 32, 33, 39, 40, 42 ],
            [ 45, 47, 48, 49, 50 ]);
my $N = shift || 0;
say find($N) ? 1 : 0;

sub find {
    my($n) = @_;
    my $row = find_row($n);
    return 0 if $row < 0;
    my $col = find_col($n, $row);
    return 0 if $col < 0;
    return 1;
}

sub find_row {
    my($n) = @_;
    my $l = 0;
    my $h = $#data;
    return -1 if $n < $data[$l][0];
    return -1 if $n > $data[$h][-1];
    while ($l < $h) {
        my $m = int(1+($l+$h)/2);
        if ($n < $data[$m][0]) {
            $h = $m-1;
        }
        elsif ($n > $data[$m][-1]) {
            $l = $m+1;
        }
        else {
            return $m;
        }
    }
    return $l;
}

sub find_col {
    my($n, $row) = @_;
    my $l = 0;
    my $h = $#{$data[$row]};
    return -1 if $n < $data[$row][0];
    return -1 if $n > $data[$row][-1];
    while ($l < $h) {
        my $m = int(1+($l+$h)/2);
        if ($n < $data[$row][$m]) {
            $h = $m-1;
        }
        elsif ($n > $data[$row][$m]) {
            $l = $m+1;
        }
        else {
            return $m;
        }
    }
    return -1 if $n != $data[$row][$l];
    return $l;
}
