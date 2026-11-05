#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - X Matrix (The Weekly Challenge 266 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a square matrix, C<$matrix>.

A square matrix is an X Matrix if all the elements in the diagonals of the
matrix are non-zero and all other elements are 0.

Write a script to find if the given matrix is an X Matrix.

=head1 FUNCTIONS

=head2 is_x_matrix($matrix)

Determines if the given square matrix satisfies the conditions of an X Matrix.

=over 4

=item * C<$matrix> - Reference to a 2D array of integers representing a square matrix.

=back

Returns 1 if the matrix is an X Matrix, 0 otherwise.

=cut

signature_for is_x_matrix => (
    method     => 0,
    positional => [ ArrayRef [ ArrayRef [Int] ] ],
);

sub is_x_matrix ($matrix) {
    my $size = scalar @$matrix;

    for my $i ( 0 .. $size - 1 ) {
        for my $j ( 0 .. $size - 1 ) {
            if ( $i == $j || $i + $j == $size - 1 ) {
                return 0 if $matrix->[$i][$j] == 0;
            }
            else {
                return 0 if $matrix->[$i][$j] != 0;
            }
        }
    }

    return 1;
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
            label  => 'Example 1',
            matrix => [
                [ 1, 0, 0, 2 ],
                [ 0, 3, 4, 0 ],
                [ 0, 5, 6, 0 ],
                [ 7, 0, 0, 1 ],
            ],
            expected => 1,
        },
        {
            label  => 'Example 2',
            matrix => [
                [ 1, 2, 3 ],
                [ 4, 5, 6 ],
                [ 7, 8, 9 ],
            ],
            expected => 0,
        },
        {
            label  => 'Example 3',
            matrix => [
                [ 1, 0, 2 ],
                [ 0, 3, 0 ],
                [ 4, 0, 5 ],
            ],
            expected => 1,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( is_x_matrix( $case->{matrix} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
