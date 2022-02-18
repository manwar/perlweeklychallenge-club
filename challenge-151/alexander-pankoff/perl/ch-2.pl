#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# TASK #2 › Rob The House
# Submitted by: Mohammad S Anwar
#
# You are planning to rob a row of houses, always starting with the first and moving in the same direction. However, you can’t rob two adjacent houses.
#
# Write a script to find the highest possible gain that can be achieved.
# Example 1:
#
# Input: @valuables = (2, 4, 5);
# Output: 7
#
# If we rob house (index=0) we get 2 and then the only house we can rob is house (index=2) where we have 5.
# So the total valuables in this case is (2 + 5) = 7.
#
#
# Example 2:
#
# Input: @valuables = (4, 2, 3, 6, 5, 3);
# Output: 13
#
# The best choice would be to first rob house (index=0) then rob house (index=3) then finally house (index=5).
# This would give us 4 + 6 + 3 =13.

use List::Util qw(all reduce sum0);

run() unless caller();

sub run() {
    my @valuables = @ARGV;
    die "Invalid input\n" unless all { m/^-?\d+$/ } @valuables;

    say rob_house(@valuables);
}

sub rob_house (@valuables) {
    my @tours = plan_tours($#valuables);

    my $best_tour = reduce sub {
        my @tour       = @$b;
        my $tour_value = sum0 map { $valuables[$_] } @tour;
        if (   $tour_value > $a->{value}
            || $tour_value == $a->{value} && @tour < @{ $a->{tour} } )
        {
            return {
                value => $tour_value,
                tour  => [@tour],
            };
        }

        return $a;

    }, { value => 0, tour => [] }, @tours;

    return $best_tour->{value};
}

sub plan_tours ( $max, $cur = 0 ) {
    return [] if $cur > $max;
    my @paths = (
        ( map { [ $cur, @$_ ] } plan_tours( $max, $cur + 2 ) ),
        plan_tours( $max, $cur + 1 )
    );

    return @paths;
}
