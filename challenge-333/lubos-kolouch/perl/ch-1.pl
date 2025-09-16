#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

ch-1.pl - Perl Weekly Challenge 333, Task 1: Straight Line

=head1 DESCRIPTION

Given a list of coordinates, determine if they form a straight line.

A set of points forms a straight line if they are collinear. This can be checked
by verifying that the slope between any pair of points is the same (or they are
all vertically aligned). For points (x1, y1), (x2, y2), (x3, y3), they are
collinear if (y2 - y1)(x3 - x1) == (y3 - y1)(x2 - x1).

=head1 AUTHOR

[Your Name]

=cut

use List::Util qw(all);

# Type alias for a point (arrayref of two numbers)
use constant Point => 'ARRAY';

sub is_straight_line {
    my (@points) = @_;

    # Less than 2 points or all same point are considered straight
    return 1 if @points < 2 || all { $_->[0] == $points[0][0] && $_->[1] == $points[0][1] } @points;

    # Check if all points are vertically aligned (same x-coordinate)
    return 1 if all { $_->[0] == $points[0][0] } @points;

    # Compute slope using cross product to avoid division
    my $dx1 = $points[1][0] - $points[0][0];
    my $dy1 = $points[1][1] - $points[0][1];

    # Check collinearity for all points against first two
    return all {
        my $dx2 = $_->[0] - $points[0][0];
        my $dy2 = $_->[1] - $points[0][1];
        $dy1 * $dx2 == $dy2 * $dx1;
    } @points[ 2 .. $#points ];
}

# Unit Tests
use Test::More tests => 5;

subtest 'Example 1' => sub {
    my @points = ( [ 2, 1 ], [ 2, 3 ], [ 2, 5 ] );
    ok( is_straight_line(@points), 'Points ([2,1], [2,3], [2,5]) form a straight line' );
};

subtest 'Example 2' => sub {
    my @points = ( [ 1, 4 ], [ 3, 4 ], [ 10, 4 ] );
    ok( is_straight_line(@points), 'Points ([1,4], [3,4], [10,4]) form a straight line' );
};

subtest 'Example 3' => sub {
    my @points = ( [ 0, 0 ], [ 1, 1 ], [ 2, 3 ] );
    ok( !is_straight_line(@points), 'Points ([0,0], [1,1], [2,3]) do not form a straight line' );
};

subtest 'Example 4' => sub {
    my @points = ( [ 1, 1 ], [ 1, 1 ], [ 1, 1 ] );
    ok( is_straight_line(@points), 'Points ([1,1], [1,1], [1,1]) form a straight line' );
};

subtest 'Example 5' => sub {
    my @points = ( [ 1000000, 1000000 ], [ 2000000, 2000000 ], [ 3000000, 3000000 ] );
    ok( is_straight_line(@points),
        'Points ([1000000,1000000], [2000000,2000000], [3000000,3000000]) form a straight line' );
};
