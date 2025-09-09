#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

=pod

=head1 NAME

ch-2.pl - Max Distance

=head1 DESCRIPTION

Given two integer arrays, this script finds the maximum difference between any pair of values
from both arrays.

=head1 METHODS

=over 4

=item max_distance(\@arr1, \@arr2)

Takes references to two arrays and returns the maximum absolute difference between any pair
of values from the two arrays.

=back

=head1 EXAMPLES

See the test cases below for examples.

=cut

sub max_distance {
    my ( $arr1, $arr2 ) = @_;

    # Input validation
    return 0 unless defined $arr1 && defined $arr2 && @$arr1 > 0 && @$arr2 > 0;

    my $max_diff = 0;

    # Calculate absolute difference for each pair and track maximum
    foreach my $x (@$arr1) {
        foreach my $y (@$arr2) {
            my $diff = abs( $x - $y );
            $max_diff = $diff if $diff > $max_diff;
        }
    }

    return $max_diff;
}

# Unit tests
is( max_distance( [ 4, 5, 7 ],     [ 9, 1, 3, 4 ] ),       6, 'Example 1' );
is( max_distance( [ 2, 3, 5, 4 ],  [ 3, 2, 5, 5, 8, 7 ] ), 6, 'Example 2' );
is( max_distance( [ 2, 1, 11, 3 ], [ 2, 5, 10, 2 ] ),      9, 'Example 3' );
is( max_distance( [ 1, 2, 3 ],     [ 3, 2, 1 ] ),          2, 'Example 4' );
is( max_distance( [ 1, 0, 2, 3 ],  [ 5, 0 ] ),             5, 'Example 5' );

done_testing();
