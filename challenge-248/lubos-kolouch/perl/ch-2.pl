#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-2.pl - Submatrix Sum

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 248, Task 2: Submatrix Sum.
Given an C<N x M> matrix C<$matrix> of integers, constructs an C<(N-1) x (M-1)>
matrix where each element C<b[i][k]> is the sum of the C<2 x 2> submatrix
starting at C<(i, k)>:
C<a[i][k] + a[i][k+1] + a[i+1][k] + a[i+1][k+1]>.

=head1 FUNCTIONS

=head2 construct_matrix($matrix)

Takes an array reference of array references of integers C<$matrix> and returns
an array reference of array references representing the C<(N-1) x (M-1)>
submatrix sums.

=cut

signature_for construct_matrix => (
    method     => 0,
    positional => [ ArrayRef [ ArrayRef [Int] ] ],
);

sub construct_matrix ($matrix) {
    my $rows = scalar @{$matrix};
    return [] if $rows < 2 || scalar @{ $matrix->[0] } < 2;

    my @result;
    for my $i ( 0 .. $rows - 2 ) {
        my $cols = scalar @{ $matrix->[$i] };
        my @row;
        for my $k ( 0 .. $cols - 2 ) {
            push @row,
              $matrix->[$i][$k] +
              $matrix->[$i][ $k + 1 ] +
              $matrix->[ $i + 1 ][$k] +
              $matrix->[ $i + 1 ][ $k + 1 ];
        }
        push @result, \@row;
    }

    return \@result;
}

is_deeply(
    construct_matrix( [ [ 1, 2, 3, 4 ], [ 5, 6, 7, 8 ], [ 9, 10, 11, 12 ] ] ),
    [ [ 14, 18, 22 ], [ 30, 34, 38 ] ],
    'Example 1'
);
is_deeply(
    construct_matrix(
        [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ]
    ),
    [ [ 2, 1, 0 ], [ 1, 2, 1 ], [ 0, 1, 2 ] ],
    'Example 2'
);
done_testing();
