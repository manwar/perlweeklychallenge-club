#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 4;

=pod

=head1 DESCRIPTION

This script determines if it's possible to form a square using all the sticks provided in an array, where each stick's length is given, and each side of the square is formed by combining one or more sticks.

=head1 FUNCTIONS

=head2 can_form_square(\@ints)

Given an array reference of integers representing stick lengths, returns 'true' if it's possible to form a square using all sticks, 'false' otherwise.

=over 4

=item * C<\@ints> - Reference to an array of integers (stick lengths).

=back

Returns 'true' or 'false'.

=cut

sub can_form_square {
    my ($ints_ref) = @_;
    my @sticks = @$ints_ref;

    # Total length must be divisible by 4
    my $total_length = 0;
    $total_length += $_ for @sticks;

    return 'false' if $total_length % 4 != 0;

    my $side_length = $total_length / 4;

    # Sort sticks in descending order to optimize
    @sticks = sort { $b <=> $a } @sticks;

    # Early rejection if any stick is longer than the side length
    return 'false' if $sticks[0] > $side_length;

    # Initialize sides
    my @sides = ( 0, 0, 0, 0 );

    return _dfs( \@sticks, 0, \@sides, $side_length ) ? 'true' : 'false';
}

sub _dfs {
    my ( $sticks_ref, $index, $sides_ref, $target ) = @_;
    if ( $index == @$sticks_ref ) {

        # Check if all sides are equal to target
        foreach my $side (@$sides_ref) {
            return 0 if $side != $target;
        }
        return 1;
    }

    my $stick = $sticks_ref->[$index];
    for my $i ( 0 .. 3 ) {
        if ( $sides_ref->[$i] + $stick <= $target ) {
            $sides_ref->[$i] += $stick;
            if ( _dfs( $sticks_ref, $index + 1, $sides_ref, $target ) ) {
                return 1;
            }
            $sides_ref->[$i] -= $stick;
        }

        # If the side is 0, no need to try other sides at this level
        if ( $sides_ref->[$i] == 0 ) {
            last;
        }
    }
    return 0;
}

# Unit Tests
is( can_form_square( [ 1, 2, 2, 2, 1 ] ),    'true',  'Example 1' );
is( can_form_square( [ 2, 2, 2, 4 ] ),       'false', 'Example 2' );
is( can_form_square( [ 2, 2, 2, 2, 4 ] ),    'false', 'Example 3' );
is( can_form_square( [ 3, 4, 1, 4, 3, 1 ] ), 'true',  'Example 4' );

done_testing();
