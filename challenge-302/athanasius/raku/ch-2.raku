use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 302
=========================

TASK #2
-------
*Step by Step*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the minimum positive start value such that step by step
sum is never less than one.

Example 1

  Input: @ints = (-3, 2, -3, 4, 2)
  Output: 5

  For start value 5.
  5 + (-3) = 2
  2 + (+2) = 4
  4 + (-3) = 1
  1 + (+4) = 5
  5 + (+2) = 7

Example 2

  Input: @ints = (1, 2)
  Output: 1

Example 3

  Input: @ints = (1, -2, -3)
  Output: 5

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
From Example 2, it appears that the start value is included in the steps, from
which it follows that the minimum *possible* start value is 1.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to signal that
   it is not a command-line flag.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 302, Task #2: Step by Step (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Pos $start = find-min-start( @ints );

    "Output: $start".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-start( List:D[Int:D] $ints --> Pos:D )
#-------------------------------------------------------------------------------
{
    my Int $start = 1;

    for $ints.reverse -> Int $n
    {
        $start -= $n;
        $start  = 1 if $start < 1;
    }

    return $start;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints  = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $start = find-min-start( @ints );

        is $start, $expected.Int, $test-name;
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
        Example 1|-3  2 -3 4 2|5
        Example 2| 1  2       |1
        Example 3| 1 -2 -3    |5
        END
}

################################################################################
