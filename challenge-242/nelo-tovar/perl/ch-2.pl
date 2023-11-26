#!/usr/bin/env perl

# Task 2: Flip Matrix
# 
# You are given n x n binary matrix.
# 
# Write a script to flip the given matrix as below.
# 
# 1 1 0
# 0 1 1
# 0 0 1
# 
# a) Reverse each row
# 
# 0 1 1
# 1 1 0
# 1 0 0
# 
# b) Invert each member
# 
# 1 0 0
# 0 0 1
# 0 1 1
# 
# 
# Example 1
# 
# Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
# Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
# 
# Example 2
# 
# Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
# Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (

    [ [ 1, 1, 0 ], 
      [ 1, 0, 1 ], 
      [ 0, 0, 0 ] 
    ],
    [ [ 1, 1, 0, 0 ], 
      [ 1, 0, 0, 1 ], 
      [ 0, 1, 1, 1 ], 
      [ 1, 0, 1, 0 ] 
    ],
);

sub reverse_matrix_rows {
    my $m1 = shift;
    my @reverse;

    foreach my $x ($m1->@*) {
        push @reverse,  [reverse $x->@*];
    }

    return \@reverse 
}

sub	invertir {
    my $m1 = shift;
    my @invert;

    foreach my $x ($m1->@*) {
        push @invert, [map {$_ == 0 ? 1 : 0} $x->@*];
    }

    return \@invert
}

for my $m (@examples) {
    my @matrix = $m->@*;

    my $reverse = reverse_matrix_rows   \@matrix;
    my $invert  = invertir $reverse;

    say 'Input  : @matrix = ', dump(@matrix);
    say 'Output :           ', dump(@$invert);
    say ' ';
}
