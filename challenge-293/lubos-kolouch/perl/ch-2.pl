#!/usr/bin/perl
use strict;
use warnings;

sub is_boomerang {
    my @points = @_;

    # Extract coordinates
    my ($x1, $y1) = @{$points[0]};
    my ($x2, $y2) = @{$points[1]};
    my ($x3, $y3) = @{$points[2]};

    # Check if all points are distinct
    my %point_set;
    $point_set{"$x1,$y1"}++;
    $point_set{"$x2,$y2"}++;
    $point_set{"$x3,$y3"}++;

    if (scalar keys %point_set < 3) {
        return 'false';
    }

    # Calculate the determinant
    my $determinant = ($x2 - $x1) * ($y3 - $y1) - ($y2 - $y1) * ($x3 - $x1);

    # If determinant is zero, points are colinear
    if ($determinant == 0) {
        return 'false';
    } else {
        return 'true';
    }
}

# Test cases
my @test_cases = (
    { points => [ [1, 1], [2, 3], [3, 2] ], expected => 'true' },
    { points => [ [1, 1], [2, 2], [3, 3] ], expected => 'false' },
    { points => [ [1, 1], [1, 2], [2, 3] ], expected => 'true' },
    { points => [ [1, 1], [1, 2], [1, 3] ], expected => 'false' },
    { points => [ [1, 1], [2, 1], [3, 1] ], expected => 'false' },
    { points => [ [0, 0], [2, 3], [4, 5] ], expected => 'true' },
);

foreach my $test (@test_cases) {
    my $result = is_boomerang(@{$test->{points}});
    print "Input: \@points = (";
    print join(', ', map { "[$_->[0], $_->[1]]" } @{$test->{points}});
    print ")\n";
    print "Output: $result\n";
    print "Expected: $test->{expected}\n";
    print "-" x 40, "\n";
}
