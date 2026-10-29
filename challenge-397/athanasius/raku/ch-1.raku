use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 397
=========================

TASK #1
-------
*Absent Smallest Positive*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the smallest absent positive integer such that it is
strictly greater than the average of all elements in the given array.

Example 1

  Input: @arr = (1, 2, 4, 5, 6)
  Output: 7

  Average: (1 + 2 + 4 + 5 + 6) / 5 = 3.6
  We need the smallest positive integer absent from nums that is strictly
  greater than 3.6.
  The positive integers greater than 3.6 are 4, 5, 6, 7, ....

  4 is in the given array.
  5 is in the given array.
  6 is in the given array.
  7 is not in.

Example 2

  Input: @arr = (-5, -2, -1, 3)
  Output: 1

  Average: (-5 -2 -1 + 3) / 4 = -1.25
  We need the smallest absent positive integer strictly greater than -1.25.
  Positive integers are 1, 2, 3, 4, ... (all are strictly greater than -1.25).

  1 is positive and absent from the given array.

Example 3

  Input: @arr = (1, 2, 3)
  Output: 4

  Average: (1 + 2 + 3) / 3 = 2.0
  We need an integer strictly greater than 2.0.

  3 is in the given array.
  4 is not in.

Example 4

  Input: @arr = (2, 3, 7, 8)
  Output: 6

  Average: (2 + 3 + 7 + 8) / 4 = 5.0
  We need an integer strictly greater than 5.0.

  6 is not in the given array.

Example 5

  Input: @arr = (1, 1, 1, 10)
  Output: 4

  Average: (1 + 1 + 1 + 10) / 4 = 3.25
  Positive integers strictly greater than 3.25: 4, 5, 6, ...

  4 is not in the given array.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 397, Task #1: Absent Smallest Positive (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@arr where { .elems > 0 && .all ~~ Int:D }  #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@arr = (%s)\n".printf: @arr.join: ', ';

    my Pos $pos = find-absent-smallest-positive( @arr );

    "Output: $pos".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-absent-smallest-positive
(
    List:D[Int:D] $arr where { .elems > 0 }
--> Pos:D
)
#-------------------------------------------------------------------------------
{
    my Int $sum = [+] @$arr;
    my Rat $avg = $sum / $arr.elems;
    my Pos $pos = (($avg + 1).floor, 1).max;

         ++$pos while $pos == $arr.any;

    return $pos;
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

        my Int @arr = $arr-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Pos $pos = find-absent-smallest-positive( @arr );

        is $pos, $expected.Int, $test-name;
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
        Example 1| 1  2  4  5 6|7
        Example 2|-5 -2 -1  3  |1
        Example 3| 1  2  3     |4
        Example 4| 2  3  7  8  |6
        Example 5| 1  1  1 10  |4
        END
}

################################################################################
