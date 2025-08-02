#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

=pod

=head1 NAME

MinDiff - Find the minimum difference between any two elements in a list.

=head1 SYNOPSIS

    use MinDiff;    # If used as a module.
    my $result = min_diff([1, 5, 8, 9]);    # returns 1

    # Or run the script directly to execute the tests:
    perl ch-2.pl

=head1 DESCRIPTION

This script provides a function that, given a list of integers, returns the minimum difference
between any two elements. The list is first sorted in numerical order, then differences between
consecutive elements are computed to determine the minimum difference.

If the list has fewer than two elements, the function returns undef.

=head1 TYPE DEFINITIONS

=over

=item IntList

A reference to an array of integers.

=back

=head1 FUNCTIONS

=head2 min_diff

    my $min = min_diff(\@ints);

Calculates and returns the minimum difference between any two elements in the list. Returns
undef if there are fewer than two elements.

=head1 AUTHOR

Original challenge by Mohammad Sajid Anwar.
Modified by Lubos Kolouch.

=cut

# Function: min_diff
# Input: $ints_ref - (IntList) Reference to an array of integers.
# Output: The minimum difference between any two elements, or undef if not applicable.
sub min_diff {
    my ($ints_ref) = @_;

    # Ensure input is an array reference.
    return unless ( ref($ints_ref) eq 'ARRAY' );

    my @ints = @$ints_ref;

    # Return undef if fewer than two elements exist.
    return if scalar(@ints) < 2;

    # Sort the array numerically.
    my @sorted = sort { $a <=> $b } @ints;

    # Initialize the minimum difference with the first adjacent pair.
    my $min_delta = $sorted[1] - $sorted[0];

# Loop through the sorted array to compute differences between adjacent elements.
    for ( my $i = 2 ; $i < scalar @sorted ; $i++ ) {
        my $delta = $sorted[$i] - $sorted[ $i - 1 ];
        if ( $delta < $min_delta ) {
            $min_delta = $delta;
        }
    }

    return $min_delta;
}

#----------------------------
# Unit Tests
#----------------------------
unless (caller) {
    use Test::More tests => 7;

    is( min_diff( [ 1, 5, 8, 9 ] ), 1, 'Example 1: [1, 5, 8, 9] returns 1' );
    is( min_diff( [ 9, 4, 1, 7 ] ), 2, 'Example 2: [9, 4, 1, 7] returns 2' );
    ok( !defined( min_diff( [] ) ),   'Empty array returns undef' );
    ok( !defined( min_diff( [42] ) ), 'Single element returns undef' );
    is( min_diff( [ 3, 3, 5, 8 ] ),
        0, 'Duplicate elements: [3, 3, 5, 8] returns 0' );
    is( min_diff( [ -10, -5, -3, -1 ] ),
        2, 'All negatives: [-10,-5,-3,-1] returns 2' );
    is( min_diff( [ -5, 0, 3, 8 ] ), 3, 'Mixed: [-5,0,3,8] returns 3' );
}

__END__
