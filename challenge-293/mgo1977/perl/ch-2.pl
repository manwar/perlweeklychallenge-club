#!/bin/perl -w


# Task 2: Boomerang
# Submitted by: Mohammad Sajid Anwar
# You are given an array of points, (x, y).

# Write a script to find out if the given points are a boomerang.

# A boomerang is a set of three points that are all distinct and not in a straight line.

# Example 1
# Input: @points = ( [1, 1], [2, 3], [3,2] )
# Output: true
# Example 2
# Input: @points = ( [1, 1], [2, 2], [3, 3] )
# Output: false
# Example 3
# Input: @points = ( [1, 1], [1, 2], [2, 3] )
# Output: true
# Example 4
# Input: @points = ( [1, 1], [1, 2], [1, 3] )
# Output: false
# Example 5
# Input: @points = ( [1, 1], [2, 1], [3, 1] )
# Output: false
# Example 6
# Input: @points = ( [0, 0], [2, 3], [4, 5] )
# Output: true



testMe(\&process, 'Example1', [ [1, 1], [2, 3], [3,2] ], 1);
testMe(\&process, 'Example2', [ [1, 1], [2, 2], [3, 3] ], 0);
testMe(\&process, 'Example3', [ [1, 1], [1, 2], [2, 3] ], 1);
testMe(\&process, 'Example4', [ [1, 1], [1, 2], [1, 3] ], 0);
testMe(\&process, 'Example5', [ [1, 1], [2, 1], [3, 1] ], 0);
testMe(\&process, 'Example6', [ [0, 0], [2, 3], [4, 5] ], 1);
testMe(\&process, 'Example7', [ [1, 1], [1, 1], [2, 8] ], 0);



sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1);

    if ( $got==$expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got=$got, expectedValue=$expectedValue\n";
    }

}



sub process {
    my $input1 = shift;


    my $point1 = $input1->[0];
    my $point2 = $input1->[1];
    my $point3 = $input1->[2];

    # All the points must be distinct
    if ( isSamePoint($point1, $point2) || isSamePoint($point2, $point3) || isSamePoint($point1, $point3)  ) {
        return 0;
    }

    # We follow this approach:
    #     1. We try to the determine the slope and offset of the line conformed by the points: point1 and point2
    #
    #     2. Then we can determine the expected value of the point3 (X coordinate) if it was part of the straight line
    #        previously determined and we can compare with the point3 value (Y coordinate)
    #
    my $slope = determineSlope($point1, $point2);

    if ( not defined $slope ) {
        # if the slope is infinite then the X of the third point must be the same as the first one
        return $point1->[0]!=$point3->[0];
    }

    my $offset = determineOffset($point1, $slope);


    # y = slope * x + offset
    my $expectedYValue = $slope * $point3->[0] + $offset;

    # the third point (y value) is not in the same straight line conformed by point1 <-> point2
    return $expectedYValue != $point3->[1];

}


sub isSamePoint {
    my $point1 = shift;
    my $point2 = shift;

    return $point1->[0]==$point2->[0] && $point1->[1]==$point2->[1];

}

sub determineSlope {
    my $point1 = shift;
    my $point2 = shift;

    if ( $point1->[0]==$point2->[0] ) {
        # infinite value
        return;
    }

    # slope = ( y2-y1 ) / ( x2-x1 )
    return ($point2->[1] - $point1->[1]) / ($point2->[0] - $point1->[0]);
}


sub determineOffset {
    my $point = shift;
    my $slope = shift;

    # offset = y1 - slope * x1
    return $point->[1] - $slope * $point->[0];
}