#!/usr/bin/env perl
#
# You are given a NxM matrix A of integers.
# 
# Write a script to construct a (N-1)x(M-1) matrix B having elements that are
# the sum over the 2x2 submatrices of A,
# 
# b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]
# 
# Example 1
# 
# Input: $a = [
#               [1,  2,  3,  4],
#               [5,  6,  7,  8],
#               [9, 10, 11, 12]
#             ]
# 
# Output: $b = [
#                [14, 18, 22],
#                [30, 34, 38]
#              ]
# 
# Example 2
# 
# Input: $a = [
#               [1, 0, 0, 0],
#               [0, 1, 0, 0],
#               [0, 0, 1, 0],
#               [0, 0, 0, 1]
#             ]
# 
# Output: $b = [
#                [2, 1, 0],
#                [1, 2, 1],
#                [0, 1, 2]
#              ]
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[
		[1,  2,  3,  4],
		[5,  6,  7,  8],
		[9, 10, 11, 12]
	],
	[
		[1, 0, 0, 0],
		[0, 1, 0, 0],
		[0, 0, 1, 0],
		[0, 0, 0, 1]
	],
];

sub submatrix_sum
{
    my $m = shift;

    my $out;
    for my $i (0..($#$m-1)) {
        for my $k (0..($#{$m->[0]}-1)) {
            $out->[$i]->[$k] = $m->[$i]->[$k]    +
                               $m->[$i]->[$k+1]  +
                               $m->[$i+1]->[$k]  +
                               $m->[$i+1]->[$k+1];
        }
    }
    return $out;
}

is_deeply(submatrix_sum($cases->[0]), [[14, 18, 22], [30, 34, 38]],       'matrix_1');
is_deeply(submatrix_sum($cases->[1]), [[2, 1, 0], [1, 2, 1], [0, 1, 2]] , 'matrix_2');
done_testing();

exit 0;

         
