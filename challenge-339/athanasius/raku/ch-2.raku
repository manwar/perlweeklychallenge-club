use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 339
=========================

TASK #2
-------
*Peak Point*

Submitted by: Mohammad Sajid Anwar

You are given an array of altitude gain.

Write a script to find the peak point gained.

Example 1

  Input: @gain = (-5, 1, 5, -9, 2)
  Output: 1

  start: 0
  1st change:  0 + (-5) = -5
  2nd change: -5 + 1    = -4
  3rd change: -4 + 5    = 1
  4th change:  1 + (-9) = -8
  5th change: -8 + 2    = -6

  max(0, -5, -4, 1, -8, -6) = 1

Example 2

  Input: @gain = (10, 10, 10, -25)
  Output: 30

  start: 0
  1st change:  0 + 10    = 10
  2nd change: 10 + 10    = 20
  3rd change: 20 + 10    = 30
  4th change: 30 + (-25) = 5

  max(0, 10, 20, 30, 5) = 30

Example 3

  Input: @gain = (3, -4, 2, 5, -6, 1)
  Output: 6

  start: 0
  1st change:  0 + 3    = 3
  2nd change:  3 + (-4) = -1
  3rd change: -1 + 2    = 1
  4th change:  1 + 5    = 6
  5th change:  6 + (-6) = 0
  6th change:  0 + 1    = 1

  max(0, 3, -1, 1, 6, 0, 1) = 6

Example 4

  Input: @gain = (-1, -2, -3, -4)
  Output: 0

  start: 0
  1st change:  0 + (-1) = -1
  2nd change: -1 + (-2) = -3
  3rd change: -3 + (-3) = -6
  4th change: -6 + (-4) = -10

  max(0, -1, -3, -6, -10) = 0

Example 5

  Input: @gain = (-10, 15, 5)
  Output: 10

  start: 0
  1st change:   0 + (-10) = -10
  2nd change: -10 + 15    = 5
  3rd change:   5 + 5     = 10

  max(0, -10, 5, 10) = 10

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Altitude gains are integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 339, Task #2: Peak Point (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of altitude gains (integers)

    *@gain where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@gain = (%s)\n".printf: @gain.join: ', ';

    my Int $peak = find-peak-point( @gain );

    "Output: $peak".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-peak-point( List:D[Int:D] $gains --> Int:D )
#-------------------------------------------------------------------------------
{
    my Int $peak     = 0;
    my Int $altitude = 0;     # Start

    for @$gains -> Int $gain
    {
        $altitude += $gain;
        $peak      = $altitude if $altitude > $peak;
    }

    return $peak;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $gains-str, $expected) = $line.split: / \| /;

        for     $test-name, $gains-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @gain = $gains-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $peak = find-peak-point( @gain );

        is $peak, $expected.Int, $test-name;
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
        Example 1| -5  1  5  -9  2  | 1
        Example 2| 10 10 10 -25     |30
        Example 3|  3 -4  2   5 -6 1| 6
        Example 4| -1 -2 -3  -4     | 0
        Example 5|-10 15  5         |10
        END
}

################################################################################
