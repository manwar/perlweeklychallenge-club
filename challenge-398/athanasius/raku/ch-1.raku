use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 398
=========================

TASK #1
-------
*Divisible Average*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers.

Write a script to return the closest integer to the mean value of all even integers that are divisible by 3. If none is divisible, return 0.

Example 1

  Input: @arr = (18, 5, 7, 11)
  Output: 18

  18 is the only even number and divisible by 3.
  Average: 18 / 1 = 18.

Example 2

  Input: @arr = (6, 12, 18, 24, 30, 40)
  Output: 18

  The qualifying numbers are 6, 12, 18, 24, and 30.
  Average: (6 + 12 + 18 + 24 + 30) / 5 = 90 / 5 = 18

Example 3

  Input: @arr = (3, 9, 15, 21, 27)
  Output: 0

  None of the elements are even.
  Since no elements qualify, return 0.

Example 4

  Input: @arr = (6, 12, 14, 20)
  Output: 9

  The qualifying numbers are 6 and 12.
  Average: (6 + 12) / 2 = 9.

Example 5

  Input: @arr = (6, 6, 6, 12, 12)
  Output: 8

  All five numbers are even and divisible by 3.
  Average: (6 + 6 + 6 + 12 + 12) / 5 = 8.4 => 8

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The input list is not empty.
2. A "positive" integer is greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of positive integers is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 397, Task #1: Divisible Average (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of positive integers

    *@arr where { .elems > 0 && .all ~~ Pos:D }
)
#===============================================================================
{
    "Input:  \@arr = (%s)\n".printf: @arr.join: ', ';

    my UInt $avg = find-divisible-average( @arr );

    "Output: $avg".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-divisible-average( List:D[Pos:D] $arr where { .elems > 0 } --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $sum   = 0;
    my UInt $count = 0;

    for @$arr -> Pos $n
    {
        if $n %% 6
        {
            $sum += $n;
            ++$count;
        }
    }

    return $count ?? (($sum / $count) + 0.5).floor !! 0;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $arr-str, $expected) = $line.split: '|';

        for     $test-name, $arr-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos  @arr = $arr-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $avg = find-divisible-average( @arr );

        is $avg, $expected.Int, $test-name;
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
        Example 1|18  5  7 11      |18
        Example 2| 6 12 18 24 30 40|18
        Example 3| 3  9 15 21 27   | 0
        Example 4| 6 12 14 20      | 9
        Example 5| 6  6  6 12 12   | 8
        END
}

################################################################################
