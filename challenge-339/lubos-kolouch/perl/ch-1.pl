#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

ch-1.pl - The Weekly Challenge 339 Task 1: Max Diff

=head1 DESCRIPTION

Given an array of at least four integers, find two disjoint pairs whose product
difference is as large as possible. The difference for pairs (a, b) and (c, d)
is defined as C<(a * b) - (c * d)>. The script enumerates all quadruples of
numbers, checks the three ways to split them into two pairs, and keeps the
maximum absolute difference of the resulting products.

=head1 AUTHOR

Lubos Kolouch

=cut

use constant IntList => 'ARRAY';
use Test::More tests => 5;

sub max_product_difference {
    my (@ints) = @_;
    die 'Need at least four integers' if @ints < 4;

    my $max_diff = 0;
    for my $i ( 0 .. $#ints - 3 ) {
        for my $j ( $i + 1 .. $#ints - 2 ) {
            for my $k ( $j + 1 .. $#ints - 1 ) {
                for my $l ( $k + 1 .. $#ints ) {
                    my @vals     = @ints[ $i, $j, $k, $l ];
                    my @pairings = (
                        [ [ $vals[0], $vals[1] ], [ $vals[2], $vals[3] ] ],
                        [ [ $vals[0], $vals[2] ], [ $vals[1], $vals[3] ] ],
                        [ [ $vals[0], $vals[3] ], [ $vals[1], $vals[2] ] ],
                    );

                    for my $pair (@pairings) {
                        my ( $first, $second ) = @$pair;
                        my $prod1 = $first->[0] * $first->[1];
                        my $prod2 = $second->[0] * $second->[1];
                        my $diff  = abs( $prod1 - $prod2 );
                        $max_diff = $diff if $diff > $max_diff;
                    }
                }
            }
        }
    }

    return $max_diff;
}

subtest 'Example 1' => sub {
    my @ints = ( 5, 9, 3, 4, 6 );
    is( max_product_difference(@ints), 42, 'Max difference is 42' );
};

subtest 'Example 2' => sub {
    my @ints = ( 1, -2, 3, -4 );
    is( max_product_difference(@ints), 10, 'Max difference is 10' );
};

subtest 'Example 3' => sub {
    my @ints = ( -3, -1, -2, -4 );
    is( max_product_difference(@ints), 10, 'Max difference is 10' );
};

subtest 'Example 4' => sub {
    my @ints = ( 10, 2, 0, 5, 1 );
    is( max_product_difference(@ints), 50, 'Max difference is 50' );
};

subtest 'Example 5' => sub {
    my @ints = ( 7, 8, 9, 10, 10 );
    is( max_product_difference(@ints), 44, 'Max difference is 44' );
};
