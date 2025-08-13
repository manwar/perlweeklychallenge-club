use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The x and y coordinates of the points in the given input list are all integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The x and y coordinates of the current location are entered on the command-
   line, followed by a list of points. Each point is given as an x coordinate
   followed by a y coordinate. All coordinates are integers.
3. If the x-coordinate of the current location is negative, it must be preceded
   by "--" to indicate that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

subset Point of List where (Int, Int);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 334, Task #2: Nearest Valid Point (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Int:D $x,            #= The x-coordinate of the current location
    Int:D $y,            #= The y-coordinate of the current location

    #| An even-sized list of point coordinates in x y order
    *@points where { .all ~~ Int:D && .elems %% 2 }
)
#===============================================================================
{
    my Point @points_ = @points.rotor: 2;

    "Input:  \$x = $x, \$y = $y, \@points = (%s)\n".printf:
        @points_.map( { '[' ~ @$_.join( ', ' )  ~ ']' } ).join: ', ';

    my Int $index = nearest-valid-point( [ $x, $y ], @points_ );

    "Output: $index".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub nearest-valid-point( Point:D $current, List:D[Point:D] $points --> Int:D )
#-------------------------------------------------------------------------------
{
    my Int  $index = -1;
    my UInt $min-dist;

    for 0 .. $points.end -> UInt $i
    {
        my Point $point = $points[ $i ];
        my UInt  $manhattan-dist;

        if    $point[ 0 ] == $current[ 0 ]
        {
            $manhattan-dist = ($point[ 1 ] - $current[ 1 ]).abs;
        }
        elsif $point[ 1 ] == $current[ 1 ]
        {
            $manhattan-dist = ($point[ 0 ] - $current[ 0 ]).abs;
        }

        if $manhattan-dist.defined &&
         (!$min-dist.defined || $min-dist > $manhattan-dist)
        {
            $index    = $i;
            $min-dist = $manhattan-dist;
        }
    }

    return $index;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $x, $y, $points-str, $exp) = $line.split: / \| /;

        for     $test-name, $x, $y, $points-str, $exp
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Point @points;

        for $points-str.split: / \; /, :skip-empty
        {
            @points.push: [ .split( / \s+ /, :skip-empty ).map: { .Int } ];
        }

        my Point $current = [ $x.Int, $y.Int ];
        my Int   $index   = nearest-valid-point( $current, @points );

        is $index, $exp.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|3|4|1 2; 3 1; 2 4; 2 3| 2
        Example 2|2|5|3 4; 2 3; 1 5; 2 5| 3
        Example 3|1|1|2 2; 3 3; 4 4     |-1
        Example 4|0|0|0 1; 1 0; 0 2; 2 0| 0
        Example 5|5|5|5 6; 6 5; 5 4; 4 5| 0
        END
}

################################################################################
