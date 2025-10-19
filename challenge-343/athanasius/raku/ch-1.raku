use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 343
=========================

TASK #1
-------
*Zero Friend*

Submitted by: Mohammad Sajid Anwar

You are given a list of numbers.

Find the number that is closest to zero and return its distance to zero.

Example 1

  Input: @nums = (4, 2, -1, 3, -2)
  Output: 1

  Values closest to 0: -1 and 2 (distance = 1 and 2)

Example 2

  Input: @nums = (-5, 5, -3, 3, -1, 1)
  Output: 1

  Values closest to 0: -1 and 1 (distance = 1)

Example 3

  Input: @ums = (7, -3, 0, 2, -8)
  Output: 0

  Values closest to 0: 0 (distance = 0)
  Exact zero wins regardless of other close values.

Example 4

  Input: @nums = (-2, -5, -1, -8)
  Output: 1

  Values closest to 0: -1 and -2 (distance = 1 and 2)

Example 5

  Input: @nums = (-2, 2, -4, 4, -1, 1)
  Output: 1

  Values closest to 0: -1 and 1 (distance = 1)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The input numbers are integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If the first element of the list is negative, it must be preceded by "--" to
   indicated that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 343, Task #1: Zero Friend (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@nums where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.join: ', ';

    my UInt $min-dist = find-min-distance( @nums );

    "Output: $min-dist".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-distance( List:D[Int:D] $nums where { .elems > 0 } --> UInt:D )
#-------------------------------------------------------------------------------
{
    return $nums.map( { .abs } ).min;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $nums-str, $expected) = $line.split: / \| /;

        for     $test-name, $nums-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @nums = $nums-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $dist = find-min-distance( @nums );

        is $dist, $expected.Int, $test-name;
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
        Example 1| 4  2 -1  3 -2  |1
        Example 2|-5  5 -3  3 -1 1|1
        Example 3| 7 -3  0  2 -8  |0
        Example 4|-2 -5 -1 -8     |1
        Example 5|-2  2 -4  4 -1 1|1
        END
}

################################################################################
