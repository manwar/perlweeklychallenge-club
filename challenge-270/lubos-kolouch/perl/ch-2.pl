#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Equalize Array (The Weekly Challenge 270 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, @ints and two integers, $x and $y.
Write a script to equalize the array with the minimum cost.

In one operation you can:
- Level 1: Increase any element by 1 with cost $x.
- Level 2: Increase any two different elements by 1 with cost $y.

=head1 FUNCTIONS

=head2 min_cost_to_equal_elements(\@ints, $x, $y)

Given an array reference of integers and operation costs $x and $y, returns the
minimum cost required to make all elements equal.

=cut

signature_for min_cost_to_equal_elements => (
    method     => 0,
    positional => [ ArrayRef [Int], Int, Int ],
);

sub min_cost_to_equal_elements ($ints, $x, $y) {
    my $n = scalar @$ints;
    return 0 if $n <= 1;
    if ( $n == 2 ) {
        return abs( $ints->[0] - $ints->[1] ) * $x;
    }

    my $min_val = $ints->[0];
    my $max_val = $ints->[0];
    for my $val (@$ints) {
        $min_val = $val if $val < $min_val;
        $max_val = $val if $val > $max_val;
    }

    if ( 2 * $x <= $y ) {
        my $cost = 0;
        $cost += ( $max_val - $_ ) * $x for @$ints;
        return $cost;
    }

    my $best  = undef;
    my $limit = $max_val + ( $max_val - $min_val ) + 2;

    for my $target ( $max_val .. $limit ) {
        my $total_diff = 0;
        $total_diff += ( $target - $_ ) for @$ints;
        my $max_diff = $target - $min_val;

        my ( $pairs, $singles );
        if ( 2 * $max_diff <= $total_diff ) {
            $pairs   = int( $total_diff / 2 );
            $singles = $total_diff % 2;
        }
        else {
            $pairs   = $total_diff - $max_diff;
            $singles = $total_diff - 2 * $pairs;
        }

        my $cost = ( $pairs * $y ) + ( $singles * $x );
        if ( !defined $best || $cost < $best ) {
            $best = $cost;
        }
    }

    return $best;
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
            ints     => [ 4, 1 ],
            x        => 3,
            y        => 2,
            expected => 9,
        },
        {
            label    => 'Example 2',
            ints     => [ 2, 3, 3, 3, 5 ],
            x        => 2,
            y        => 1,
            expected => 6,
        },
        {
            label    => 'Target higher than max',
            ints     => [ 1, 2, 2 ],
            x        => 3,
            y        => 1,
            expected => 2,
        },
        {
            label    => 'Already equal',
            ints     => [ 5, 5, 5 ],
            x        => 2,
            y        => 1,
            expected => 0,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is(
            min_cost_to_equal_elements( $case->{ints}, $case->{x}, $case->{y} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
