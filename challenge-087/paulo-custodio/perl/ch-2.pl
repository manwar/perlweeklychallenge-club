#!/usr/bin/perl

# Challenge 087
#
# TASK #2 › Largest Rectangle
# Submitted by: Mohammad S Anwar
# You are given matrix m x n with 0 and 1.
#
# Write a script to find the largest rectangle containing only 1. Print 0 if none found.
#
# Example 1:
# Input:
#     [ 0 0 0 1 0 0 ]
#     [ 1 1 1 0 0 0 ]
#     [ 0 0 1 0 0 1 ]
#     [ 1 1 1 1 1 0 ]
#     [ 1 1 1 1 1 0 ]
#
# Output:
#     [ 1 1 1 1 1 ]
#     [ 1 1 1 1 1 ]
# Example 2:
# Input:
#     [ 1 0 1 0 1 0 ]
#     [ 0 1 0 1 0 1 ]
#     [ 1 0 1 0 1 0 ]
#     [ 0 1 0 1 0 1 ]
#
# Output: 0
# Example 3:
# Input:
#     [ 0 0 0 1 1 1 ]
#     [ 1 1 1 1 1 1 ]
#     [ 0 0 1 0 0 1 ]
#     [ 0 0 1 1 1 1 ]
#     [ 0 0 1 1 1 1 ]
#
# Output:
#     [ 1 1 1 1 ]
#     [ 1 1 1 1 ]

use strict;
use warnings;
use 5.030;

# read matrix from input
my @m;
my $ncols;
while (<>) {
    my @cols = split(' ', s/\D/ /gr);       # ignore all but numbers
    die "invalid matrix\n" if defined($ncols) && $ncols != scalar(@cols);
    $ncols = scalar(@cols);
    push @m, \@cols;
}

# find largest rectangle
my($h, $w) = largest(@m);
if ($h == 0) {
    say 0;
}
else {
    for (1..$h) {
        say "[ ", ("1 " x $w), "]";
    }
}

# largest rectangle
sub largest {
    my(@m) = @_;
    my($h, $w) = (0, 0);
    for my $r (0 .. $#m) {                  # try each row
        for my $c (0 .. $#{$m[0]}) {        # and column
            if ($m[$r][$c]) {               # have a 1
                my($h1, $w1) = largest_horiz($r, $c, @m);
                if ($h1*$w1 > 1 && $h1*$w1 > $h*$w) {
                    ($h, $w) = ($h1, $w1);
                }
                ($h1, $w1) = largest_vert($r, $c, @m);
                if ($h1*$w1 > 1 && $h1*$w1 > $h*$w) {
                    ($h, $w) = ($h1, $w1);
                }
            }
        }
    }
    return ($h, $w);
}

# largest rectangle horizontally starting at (r0,c0)
sub largest_horiz {
    my($r0, $c0, @m) = @_;

    # find longest row of 1's
    my $c = $c0+1;
    while ($c < @{$m[0]} && $m[$r0][$c]) {
        $c++;
    }

    # search for bottom rows of 1's of the same size
    my $r = $r0+1;
    while ($r < @m && all_ones(@{$m[$r]}[$c0 .. $c-1])) {
        $r++;
    }

    return ($r-$r0, $c-$c0);
}

# largest rectangle vertically starting at (r0,c0)
sub largest_vert {
    my($r0, $c0, @m) = @_;

    # find longest column of 1's
    my $r = $r0+1;
    while ($r < @m && $m[$r][$c0]) {
        $r++;
    }

    # search for right columns of 1's of the same size
    my $c = $c0+1;
    while ($c < @{$m[0]} && all_ones(vert_slice($c, @m[$r0 .. $r-1]))) {
        $c++;
    }

    return ($r-$r0, $c-$c0);
}

# check an array for 1's
sub all_ones {
    my(@a) = @_;
    my $ones = 1;
    for (@a) {
        $ones = $ones && $_;
    }
    return $ones;
}

# extract a vertical slice of an array
sub vert_slice {
    my($c, @m) = @_;
    my @r;
    for (0 .. $#m) {
        push @r, $m[$_][$c];
    }
    return @r;
}
