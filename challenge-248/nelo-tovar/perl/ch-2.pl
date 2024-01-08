#!/usr/bin/env perl

# The Weekly Challenge 248 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/
#
# Task 2 - Submatrix Sum
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use Algorithm::Combinatorics qw(combinations);
use Data::Dump qw(dump);

my @examples = (
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
    ]
);

sub submatrix_sum {
    my $matrix = shift;
    my $rows = scalar @$matrix - 1 ;
    my $cols = scalar @{$matrix->[0]} - 1 ;
    my @sum = ();

    for (my $i = 0; $i < $rows; $i++) {
        for (my $k = 0; $k < $cols; $k++) {
            $sum[$i][$k] = $matrix->[$i][$k]   + $matrix->[$i][$k+1] + 
                           $matrix->[$i+1][$k] + $matrix->[$i+1][$k+1];
        }
    }
     
    return \@sum;
}

for my $elements (@examples) {
    my $b = submatrix_sum $elements;

    say 'Input : $a = [';
    foreach my $x (@$elements) {
        printf("%15s%s,\n", ' ', dump($x))
    };
    printf("%14s\n", ']');
    say 'Output : $b = [ ';
    foreach my $x (@$b) {
        printf("%16s%s,\n", ' ', dump($x))
    };
    printf("%15s\n", ']');
    say ' ';
}
