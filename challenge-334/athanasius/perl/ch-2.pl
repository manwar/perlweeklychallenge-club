#!perl

################################################################################
=comment

Perl Weekly Challenge 334
=========================

TASK #2
-------
*Nearest Valid Point*

Submitted by: Mohammad Sajid Anwar

You are given current location as two integers: x and y. You are also given a
list of points on the grid.

A point is considered valid if it shares either the same x-coordinate or the
same y-coordinate as the current location.

Write a script to return the index of the valid point that has the smallest
Manhattan distance to the current location. If multiple valid points are tied
for the smallest distance, return the one with the lowest index. If no valid
points exist, return -1.

    The Manhattan distance between two points (x1, y1) and (x2, y2) is
    calculated as: |x1 - x2| + |y1 - y2|

Example 1

  Input: $x = 3, $y = 4, @points ([1, 2], [3, 1], [2, 4], [2, 3])
  Output: 2

  Valid points: [3, 1] (same x), [2, 4] (same y)

  Manhattan distances:
      [3, 1] => |3-3| + |4-1| = 3
      [2, 4] => |3-2| + |4-4| = 1

  Closest valid point is [2, 4] at index 2.

Example 2

  Input: $x = 2, $y = 5, @points ([3, 4], [2, 3], [1, 5], [2, 5])
  Output: 3

  Valid points: [2, 3], [1, 5], [2, 5]

  Manhattan distances:
      [2, 3] => 2
      [1, 5] => 1
      [2, 5] => 0

  Closest valid point is [2, 5] at index 3.

Example 3

  Input: $x = 1, $y = 1, @points ([2, 2], [3, 3], [4, 4])
  Output: -1

  No point shares x or y with (1, 1).

Example 4

  Input: $x = 0, $y = 0, @points ([0, 1], [1, 0], [0, 2], [2, 0])
  Output: 0

  Valid points: all of them

  Manhattan distances:
      [0, 1] => 1
      [1, 0] => 1
      [0, 2] => 2
      [2, 0] => 2

  Tie between index 0 and 1, pick the smaller index: 0

Example 5

  Input: $x = 5, $y = 5, @points ([5, 6], [6, 5], [5, 4], [4, 5])
  Output: 0

  Valid points: all of them
      [5, 6] => 1
      [6, 5] => 1
      [5, 4] => 1
      [4, 5] => 1

  All tie, return the one with the lowest index: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The x and y coordinates of the points in the given input list are all integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The x and y coordinates of the current location are entered on the command-
   line, followed by a list of points. Each point is given as an x coordinate
   followed by a y coordinate. All coordinates are integers.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( pairs  );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <x> <y> [<points> ...]
  perl $0

    <x>               The x-coordinate of the current location
    <y>               The y-coordinate of the current location
    [<points> ...]    An even-sized list of point coordinates in x y order
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 334, Task #2: Nearest Valid Point (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc % 2 == 1)
    {
        error( 'Expected an even number of command-line arguments, found ' .
                $argc );
    }
    else
    {
        my  ($x, $y, @coords) = @ARGV;

        for ($x, $y, @coords)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        my @points = pairs @coords;

        printf "Input:  \$x = $x, \$y = $y, \@points = (%s)\n",
            join ', ', map { '[' . join( ', ', @$_ ) . ']' } @points;

        my $index = nearest_valid_point( [ $x, $y ], \@points );

        print "Output: $index\n";
    }
}

#-------------------------------------------------------------------------------
sub nearest_valid_point
#-------------------------------------------------------------------------------
{
    my ($current, $points) = @_;
    my  $index = -1;
    my  $min_dist;

    for my $i (0 .. $#$points)
    {
        my $point = $points->[ $i ];
        my $manhattan_dist;

        if    ($point->[ 0 ] == $current->[ 0 ])
        {
            $manhattan_dist = abs( $point->[ 1 ] - $current->[ 1 ] );
        }
        elsif ($point->[ 1 ] == $current->[ 1 ])
        {
            $manhattan_dist = abs( $point->[ 0 ] - $current->[ 0 ] );
        }

        if (defined $manhattan_dist &&
          (!defined $min_dist || $min_dist > $manhattan_dist))
        {
            $index    = $i;
            $min_dist = $manhattan_dist;
        }
    }

    return $index;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $x, $y, $points_str, $expected) = split / \| /x, $line;

        for ($test_name, $x, $y, $points_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @points;

        for (split / \s* \; \s* /x, $points_str)
        {
            push @points, [ split / \s+ /x, $_ ];
        }

        my $index = nearest_valid_point( [ $x, $y ], \@points );

        is $index, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|3|4|1 2; 3 1; 2 4; 2 3| 2
Example 2|2|5|3 4; 2 3; 1 5; 2 5| 3
Example 3|1|1|2 2; 3 3; 4 4     |-1
Example 4|0|0|0 1; 1 0; 0 2; 2 0| 0
Example 5|5|5|5 6; 6 5; 5 4; 4 5| 0
