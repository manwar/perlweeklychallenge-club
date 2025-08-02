#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

=pod

=head1 NAME

MinGap - Find the element after which the smallest gap occurs in a sorted list of integers.

=head1 SYNOPSIS

    # To use as a module:
    use MinGap;
    my $result = min_gap([2, 8, 10, 11, 15]);    # returns 11

    # Or run the script to execute the tests:
    perl ch-1.pl

=head1 DESCRIPTION

This script finds, for a given sorted (increasing order) array of integers (an IntList),
the element immediately following the smallest gap between consecutive elements.

For example, given the array C<[2, 8, 10, 11, 15]>, the successive gaps are:

    8 - 2   => 6
    10 - 8  => 2
    11 - 10 => 1
    15 - 11 => 4

The smallest gap is C<1> (found between C<10> and C<11>), so the function returns C<11>.

If the input array contains fewer than two elements, the function returns C<undef>.

=head1 TYPE DEFINITIONS

=over

=item IntList

A reference to an array of integers. For example, C<[1,2,3]> is an IntList.

=back

=head1 FUNCTIONS

=head2 min_gap

    my $result = min_gap($ints_ref);

Takes an IntList and returns the element immediately following the smallest gap.
Returns C<undef> if the array has fewer than two elements.

=head1 AUTHOR

Original challenge by Mohammad Sajid Anwar.
Modified by Lubos Kolouch.

=cut

# Function: min_gap
# Input: $ints_ref - (IntList) Reference to an array of integers.
# Output: The element after which the smallest gap occurs, or undef if not applicable.
sub min_gap {
    my ($ints_ref) = @_;

    # Validate that input is an array reference.
    return unless ( ref($ints_ref) eq 'ARRAY' );

    my $n = scalar @$ints_ref;
    return if $n < 2;

    # Initialize the minimum delta using the gap between the first two elements.
    my $min_delta = $ints_ref->[1] - $ints_ref->[0];
    my $result    = $ints_ref->[1];

    for ( my $i = 2 ; $i < $n ; $i++ ) {
        my $diff = $ints_ref->[$i] - $ints_ref->[ $i - 1 ];
        if ( $diff < $min_delta ) {
            $min_delta = $diff;
            $result    = $ints_ref->[$i];
        }
    }

    return $result;
}

#----------------------------
# Unit Tests
#----------------------------
# The following tests are executed when this file is run directly.
unless (caller) {
    use Test::More tests => 7;

    is( min_gap( [ 2, 8, 10, 11, 15 ] ),
        11, 'Example 1: [2,8,10,11,15] returns 11' );
    is( min_gap( [ 1, 5, 6, 7, 14 ] ), 6, 'Example 2: [1,5,6,7,14] returns 6' );
    is( min_gap( [ 8, 20, 25, 28 ] ), 28,
        'Example 3: [8,20,25,28] returns 28' );
    ok( !defined( min_gap( [] ) ),   'Empty array returns undef' );
    ok( !defined( min_gap( [42] ) ), 'Single element array returns undef' );
    is( min_gap( [ 1, 3, 5, 6, 9 ] ),
        6, 'Tied gap - first occurrence: [1,3,5,6,9] returns 6' );
    is( min_gap( [ 1, 2, 3, 4 ] ),
        2, 'Tied gap - first occurrence: [1,2,3,4] returns 2' );
}
