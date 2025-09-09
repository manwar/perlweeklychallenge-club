#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

=pod

=head1 NAME

ch-1.pl - Perl Weekly Challenge 334, Task 1: Range Sum

=head1 DESCRIPTION

Given a list of integers and two indices, return the sum of integers between the given indices (inclusive).

=head1 FUNCTION

=head2 range_sum

Calculates the sum of integers between indices x and y (inclusive).

=over 4

=item * @ints - Array of integers
=item * $x - Starting index
=item * $y - Ending index

=back

Returns: Integer sum of elements between indices x and y.

=cut

sub range_sum {
    my ( $ints, $x, $y ) = @_;

    # Input validation
    return 0 unless @$ints && $x <= $y && $x >= 0 && $y < @$ints;

    my $sum = 0;
    $sum += $ints->[$_] for $x .. $y;
    return $sum;
}

# Test cases
is( range_sum( [ -2, 0, 3, -5, 2, -1 ], 0, 2 ),  1, "Test Case 1" );
is( range_sum( [ 1, -2, 3, -4, 5 ],     1, 3 ), -3, "Test Case 2" );
is( range_sum( [ 1, 0, 2, -1, 3 ],      3, 4 ),  2, "Test Case 3" );
is( range_sum( [ -5, 4, -3, 2, -1, 0 ], 0, 3 ), -2, "Test Case 4" );
is( range_sum( [ -1, 0, 2, -3, -2, 1 ], 0, 2 ),  1, "Test Case 5" );

done_testing();
