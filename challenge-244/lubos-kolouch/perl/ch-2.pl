#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(min max);
use Math::Combinatorics;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-2.pl - Group Hero

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 244, Task 2: Group Hero.
Given an array of integers representing strength, returns the sum of the powers
of all possible non-empty combinations, where power is defined as the square
of the largest number in a combination multiplied by the smallest.

=head1 FUNCTIONS

=head2 group_hero_power($nums)

Returns the total power summed across all non-empty combinations of C<$nums>.

=cut

signature_for group_hero_power => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub group_hero_power ($nums) {
    my $total_power = 0;

    for my $i ( 1 .. scalar @{$nums} ) {
        my $combinat = Math::Combinatorics->new( count => $i, data => [@{$nums}] );
        while ( my @combo = $combinat->next_combination ) {
            my $power = max(@combo)**2 * min(@combo);
            $total_power += $power;
        }
    }

    return $total_power;
}

is( group_hero_power( [ 2, 1, 4 ] ), 141, 'Example 1' );
done_testing();
