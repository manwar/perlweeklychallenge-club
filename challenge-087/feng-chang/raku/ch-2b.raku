#!/bin/env raku

=begin Challenge

You are given matrix m x n with 0 and 1.
Write a script to find the largest rectangle containing only 1. Print 0 if none found.

Example 1:
Input:
    [ 0 0 0 1 0 0 ]
    [ 1 1 1 0 0 0 ]
    [ 0 0 1 0 0 1 ]
    [ 1 1 1 1 1 0 ]
    [ 1 1 1 1 1 0 ]
Output:
    [ 1 1 1 1 1 ]
    [ 1 1 1 1 1 ]

Example 2:
Input:
    [ 1 0 1 0 1 0 ]
    [ 0 1 0 1 0 1 ]
    [ 1 0 1 0 1 0 ]
    [ 0 1 0 1 0 1 ]
Output: 0

Example 3:
Input:
    [ 0 0 0 1 1 1 ]
    [ 1 1 1 1 1 1 ]
    [ 0 0 1 0 0 1 ]
    [ 0 0 1 1 1 1 ]
    [ 0 0 1 1 1 1 ]
Output:
    [ 1 1 1 1 ]
    [ 1 1 1 1 ]

=end Challenge

my @N;
for $*IN.lines -> $line {
    @N.push($line.words».Int);
}

my \高 = @N.elems;
my \宽 = @N[0].elems;

my $a = ((0 ..^ 高-1 X 0 ..^ 宽-1) X (1 ..^ 高 X 1 ..^ 宽))
	.grep({ $_[1;0] > $_[0;0] and $_[1;1] > $_[0;1] })
	.grep({ @N[$_[0;0]..$_[1;0]; $_[0;1]..$_[1;1]].all == 1 })
	.max({ ($_[1;0] - $_[0;0] + 1) * ($_[1;1] - $_[0;1] + 1) });

if $a.elems > 1 {
	put (1) xx ($a[1;1] - $a[0;1] + 1) for ^($a[1;0] - $a[0;0] + 1);
}
