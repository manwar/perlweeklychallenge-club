#!/usr/bin/env perl

use v5.20;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Data::Dumper;

=pod
TASK #2 › Find Square
Submitted by: Mohammad S Anwar

You are given matrix of size m x n with only 1 and 0.

Write a script to find the count of squares having all four corners set as 1.
Example 1:

Input: [ 0 1 0 1 ]
       [ 0 0 1 0 ]
       [ 1 1 0 1 ]
       [ 1 0 0 1 ]

Output: 1

Explanation:
There is one square (3x3) in the given matrix with four corners as 1 starts at r=1;c=2.

[ 1 0 1 ]
[ 0 1 0 ]
[ 1 0 1 ]

Example 2:

Input: [ 1 1 0 1 ]
       [ 1 1 0 0 ]
       [ 0 1 1 1 ]
       [ 1 0 1 1 ]

Output: 4

Explanation:
There is one square (4x4) in the given matrix with four corners as 1 starts at r=1;c=1.
There is one square (3x3) in the given matrix with four corners as 1 starts at r=1;c=2.
There are two squares (2x2) in the given matrix with four corners as 1. First starts at r=1;c=1 and second starts at r=3;c=3.
Example 3:

Input: [ 0 1 0 1 ]
       [ 1 0 1 0 ]
       [ 0 1 0 0 ]
       [ 1 0 0 1 ]

Output: 0
=cut

#<<<
sub count_squares($M) {
    no warnings;
    my $r; my $i--;
    while($$M[++$i].'0'){my $j--;
    while($$M[$i][++$j].'0'){my $k;
    while($$M[$i][++$k+$j].'0'){
        $r+=$$M[$i+$k][$j]&$$M[$i][$j+$k]
        &$$M[$i][$j]&$$M[$i+$k][$j+$k]}}}
    $r;
}
#>>>

# Tests.
my $M;
my $row_cnt;

while (<DATA>) {
    next if /^\s*$/ || /^#/;

    if (/\[/) {

        # Next matrix row.
        $M->[ $row_cnt++ ] = [m/\b[01]\b/g];
    }
    else {
        # Expected output.
        my ($expected) = m/\d+/g;

        $Data::Dumper::Terse  = 1;
        $Data::Dumper::Indent = 0;

        my $actual = count_squares($M);
        $expected == $actual
          || die "Error for "
          . Dumper($M)
          . ". Expected $expected, got $actual.";

        # Reset variables.
        undef $M;
        undef $row_cnt;
    }
}

__DATA__
# Test data.
[ 0 1 0 1 ]
[ 0 0 1 0 ]
[ 1 1 0 1 ]
[ 1 0 0 1 ]
1

[ 1 1 0 1 ]
[ 1 1 0 0 ]
[ 0 1 1 1 ]
[ 1 0 1 1 ]
4

[ 0 1 0 1 ]
[ 1 0 1 0 ]
[ 0 1 0 0 ]
[ 1 0 0 1 ]
0

[ 0 1 0 1 ]
[ 1 0 1 0 ]
[ 0 1 0 1 ]
1

[ 1 0 1 ]
[ 1 0 0 ]
[ 1 1 1 ]
[ 0 1 1 ]
2
