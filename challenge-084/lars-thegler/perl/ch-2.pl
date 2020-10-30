#!/usr/bin/env perl

use Modern::Perl;
use Mojo::Util 'trim';
use List::Util 'min';

# TASK #2 › Find Square
# Submitted by: Mohammad S Anwar
# You are given matrix of size m x n with only 1 and 0.

# Write a script to find the count of squares having all four corners set as 1.

# Example 1:
# Input: [ 0 1 0 1 ]
#        [ 0 0 1 0 ]
#        [ 1 1 0 1 ]
#        [ 1 0 0 1 ]

# Output: 1
# Explanation:
# There is one square (3x3) in the given matrix with four corners as 1 starts at r=1;c=2.
# [ 1 0 1 ]
# [ 0 1 0 ]
# [ 1 0 1 ]
# Example 2:
# Input: [ 1 1 0 1 ]
#        [ 1 1 0 0 ]
#        [ 0 1 1 1 ]
#        [ 1 0 1 1 ]

# Output: 4
# Explanation:
# There is one square (4x4) in the given matrix with four corners as 1 starts at r=1;c=1.
# There is one square (3x3) in the given matrix with four corners as 1 starts at r=1;c=2.
# There are two squares (2x2) in the given matrix with four corners as 1. First starts at r=1;c=1 and second starts at r=3;c=3.
# Example 3:
# Input: [ 0 1 0 1 ]
#        [ 1 0 1 0 ]
#        [ 0 1 0 0 ]
#        [ 1 0 0 1 ]

# Output: 0

my $input = shift;
die 'incorrect form' unless $input =~ /^( \[\s ([01]\s)+ \]\s* )+$/x;
my @rows = split /\]\s*\[/, $input;
$_ =~ s/[ \[ \] ]//gx for @rows;
my $n = scalar @rows;       # n: number of rows
my $m = length $rows[0];    # m: number of columns

for ( 0 .. $n - 1 ) {
    die 'incorrect number of columns' unless length $rows[$_] == $m;
}

my @matrix = map { split '', $_ } @rows;

my $max_s = min $n, $m;     # max_s: largest square possible

my $number_of_all_ones_squares = 0;
for my $s ( 2 .. $max_s ) {    # for each square size
    for my $r ( 0 .. $n - $s ) {    # for each possible row
        for my $c ( 0 .. $m - $s ) {    # for each possible row

            my $all_ones = 1;
            for my $o ( 0, $s - 1, ( $s - 1 ) * $m, ( $s - 1 ) * ( $m + 1 ) ) {    # four corners
                my $i = $r * $m + $c + $o;
                $all_ones *= $matrix[$i];
            }
            $number_of_all_ones_squares += $all_ones;
        }
    }
}

say $number_of_all_ones_squares;
