#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Zero Matrix
# Submitted by: Mohammad S Anwar
#
# You are given a matrix of size M x N having only 0s and 1s.
#
# Write a script to set the entire row and column to 0 if an element is 0.
# Example 1
#
# Input: [1, 0, 1]
#        [1, 1, 1]
#        [1, 1, 1]
#
# Output: [0, 0, 0]
#         [1, 0, 1]
#         [1, 0, 1]
#
# Example 2
#
# Input: [1, 0, 1]
#        [1, 1, 1]
#        [1, 0, 1]
#
# Output: [0, 0, 0]
#         [1, 0, 1]
#         [0, 0, 0]

my @m1 = ([1,0,1],
          [1,1,1],
          [1,1,1]);

my @m2 = ([1,0,1],
          [1,1,1],
          [1,0,1]);

print_mat(\@m1);
print_mat(\@m2);

zero_mat(\@m1);
zero_mat(\@m2);

print_mat(\@m1);
print_mat(\@m2);

sub print_mat($ar) {
    for my $row ($ar->@*) {
        printf "[%s]\n", join(", ", $row->@*);
    }
    print "\n";
}

sub zero_mat($ar) {
    my @row_flag;
    my @col_flag;

    # make a first pass to find where the 0s are
    for my $r (0..$#$ar) {
        my $row = $ar->[$r];
        for my $c (0..$#$row) {
            if ($ar->[$r][$c] == 0) {
                $row_flag[$r] = $col_flag[$c] = 1;
            } else {
                $row_flag[$r] //= 0;
                $col_flag[$c] //= 0;
            }
        }
    }

    # now set the cells to 0 if there was a 0 in its row or column
    for my $r (0..$#$ar) {
        my $row = $ar->[$r];
        for my $c (0..$#$row) {
            if ($row_flag[$r] || $col_flag[$c]) {
                $ar->[$r][$c] = 0;
            }
        }
    }
}
