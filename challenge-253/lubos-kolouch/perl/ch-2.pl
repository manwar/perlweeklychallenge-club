#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-2.pl - Weakest Row

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 253, Task 2: Weakest Row.
Orders the rows of a binary matrix from weakest to strongest, where a row
with fewer 1s is weaker, and ties are broken by smaller row index.

=head1 FUNCTIONS

=head2 weakest_row($matrix)

Takes an array reference C<$matrix> of binary integer rows and returns an
array reference of row indices ordered from weakest to strongest.

=cut

signature_for weakest_row => (
    method     => 0,
    positional => [ ArrayRef[ ArrayRef[Int] ] ],
);

sub weakest_row ($matrix) {
    my @row_strength = map {
        my $ones = scalar grep { $_ == 1 } @{ $matrix->[$_] };
        [ $ones, $_ ];
    } 0 .. $#$matrix;

    @row_strength = sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] } @row_strength;

    return [ map { $_->[1] } @row_strength ];
}

is_deeply(
    weakest_row(
        [
            [ 1, 1, 0, 0, 0 ],
            [ 1, 1, 1, 1, 0 ],
            [ 1, 0, 0, 0, 0 ],
            [ 1, 1, 0, 0, 0 ],
            [ 1, 1, 1, 1, 1 ],
        ]
    ),
    [ 2, 0, 3, 1, 4 ],
    'Example 1: 5x5 matrix'
);
is_deeply(
    weakest_row(
        [
            [ 1, 0, 0, 0 ],
            [ 1, 1, 1, 1 ],
            [ 1, 0, 0, 0 ],
            [ 1, 0, 0, 0 ],
        ]
    ),
    [ 0, 2, 3, 1 ],
    'Example 2: 4x4 matrix with ties'
);
done_testing();
