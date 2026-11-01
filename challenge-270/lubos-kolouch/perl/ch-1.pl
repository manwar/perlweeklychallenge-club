#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Special Positions in a Binary Matrix (The Weekly Challenge 270 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an m x n binary matrix.
A position (i, j) is called special if matrix[i][j] == 1 and all other elements
in row i and column j are 0 (rows and columns are 0-indexed).

This script counts and returns the number of special positions.

=head1 FUNCTIONS

=head2 num_special_positions($matrix)

Given a reference to a 2D array of integers, returns the count of special positions.

=cut

signature_for num_special_positions => (
    method     => 0,
    positional => [ ArrayRef [ ArrayRef [Int] ] ],
);

sub num_special_positions ($matrix) {
    my $rows = scalar @$matrix;
    return 0 if $rows == 0;
    my $cols = scalar @{ $matrix->[0] };
    return 0 if $cols == 0;

    my @row_sums = (0) x $rows;
    my @col_sums = (0) x $cols;

    for my $i ( 0 .. $rows - 1 ) {
        for my $j ( 0 .. $cols - 1 ) {
            if ( $matrix->[$i][$j] == 1 ) {
                $row_sums[$i]++;
                $col_sums[$j]++;
            }
        }
    }

    my $special_count = 0;
    for my $i ( 0 .. $rows - 1 ) {
        next if $row_sums[$i] != 1;
        for my $j ( 0 .. $cols - 1 ) {
            if ( $matrix->[$i][$j] == 1 && $col_sums[$j] == 1 ) {
                $special_count++;
            }
        }
    }

    return $special_count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    _run_tests();
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            matrix   => [ [ 1, 0, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ],
            expected => 1,
        },
        {
            label    => 'Example 2',
            matrix   => [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ],
            expected => 3,
        },
        {
            label    => 'Non-square binary matrix',
            matrix   => [ [ 0, 0, 0, 1 ], [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ] ],
            expected => 3,
        },
        {
            label    => 'No special positions',
            matrix   => [ [ 1, 1 ], [ 1, 1 ] ],
            expected => 0,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( num_special_positions( $case->{matrix} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=cut
