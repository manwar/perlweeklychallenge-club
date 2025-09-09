#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

=pod

=head1 NAME

ch-1.pl - Highest Row

=head1 DESCRIPTION

Given an m x n matrix, this script finds the highest row sum in the matrix.

=head1 METHODS

=over 4

=item highest_row(\@matrix)

Takes a reference to a 2D array (matrix) and returns the maximum sum of any row.

=back

=head1 EXAMPLES

See the test cases below for examples.

=cut

sub highest_row {
    my ($matrix) = @_;

    # Input validation
    return 0 unless defined $matrix && @$matrix > 0;

    my $max_sum = 0;

    # Calculate sum for each row and track maximum
    foreach my $row (@$matrix) {
        my $row_sum = 0;
        $row_sum += $_ for @$row;
        $max_sum = $row_sum if $row_sum > $max_sum;
    }

    return $max_sum;
}

# Unit tests
is( highest_row( [ [ 4, 4, 4, 4 ], [ 10, 0, 0, 0 ], [ 2, 2, 2, 9 ] ] ),            16,  'Example 1' );
is( highest_row( [ [ 1, 5 ], [ 7, 3 ], [ 3, 5 ] ] ),                               10,  'Example 2' );
is( highest_row( [ [ 1, 2, 3 ], [ 3, 2, 1 ] ] ),                                   6,   'Example 3' );
is( highest_row( [ [ 2, 8, 7 ], [ 7, 1, 3 ], [ 1, 9, 5 ] ] ),                      17,  'Example 4' );
is( highest_row( [ [ 10, 20, 30 ], [ 5, 5, 5 ], [ 0, 100, 0 ], [ 25, 25, 25 ] ] ), 100, 'Example 5' );

done_testing();
