#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

=pod

=head1 DESCRIPTION

This script simulates the Order Game on a given array of integers whose length is a power of 2.

In the Order Game:

- At each round, the array is reduced by pairing elements.
- For each pair, if it's at an even index (starting from 0), take the minimum of the pair.
- If it's at an odd index, take the maximum of the pair.
- This process repeats until only one element remains.

=head1 FUNCTIONS

=head2 order_game(\@ints)

Simulates the Order Game and returns the last remaining element.

=over 4

=item * C<\@ints> - Reference to an array of integers (length is a power of 2).

=back

Returns the last remaining integer after playing the game.

=cut

sub order_game {
    my ($ints_ref) = @_;
    my @current_list = @$ints_ref;
    while (@current_list > 1) {
        my @next_list;
        my $n = scalar @current_list;
        for (my $i = 0; $i < $n / 2; $i++) {
            if ($i % 2 == 0) {
                # Even index: take minimum
                push @next_list, min($current_list[2 * $i], $current_list[2 * $i + 1]);
            } else {
                # Odd index: take maximum
                push @next_list, max($current_list[2 * $i], $current_list[2 * $i + 1]);
            }
        }
        @current_list = @next_list;
    }
    return $current_list[0];
}

sub min {
    my ($a, $b) = @_;
    return $a < $b ? $a : $b;
}

sub max {
    my ($a, $b) = @_;
    return $a > $b ? $a : $b;
}

# Unit Tests
is(order_game([2, 1, 4, 5, 6, 3, 0, 2]), 1, 'Example 1');
is(order_game([0, 5, 3, 2]), 0, 'Example 2');
is(order_game([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]), 2, 'Example 3');
