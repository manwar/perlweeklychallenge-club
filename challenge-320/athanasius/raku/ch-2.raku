use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 320
=========================

TASK #2
-------
*Sum Difference*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers.

Write a script to return the absolute difference between digit sum and element
sum of the given array.

Example 1

  Input: @ints = (1, 23, 4, 5)
  Output: 18

  Element sum: 1 + 23 + 4 + 5 => 33
  Digit sum: 1 + 2 + 3 + 4 + 5 => 15
  Absolute difference: | 33 - 15 | => 18

Example 2

  Input: @ints = (1, 2, 3, 4, 5)
  Output: 0

  Element sum: 1 + 2 + 3 + 4 + 5 => 15
  Digit sum: 1 + 2 + 3 + 4 + 5 => 15
  Absolute difference: | 15 - 15 | => 0

Example 3

  Input: @ints = (1, 2, 34)
  Output: 27

  Element sum: 1 + 2 + 34 => 37
  Digit sum: 1 + 2 + 3 + 4 => 10
  Absolute difference: | 37 - 10 | => 27

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
A "positive" integer is greater than or equal to zero (i.e., unsigned).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 320, Task #2: Sum Difference (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of unsigned integers

    *@ints where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    @ints .= map: { $_ + 0 };                   # Normalize (remove initial "+")

    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt $sum-diff = find-sum-diff( @ints );

    "Output: $sum-diff".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-sum-diff( List:D[UInt:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $element-sum = 0;
    my UInt $digit-sum   = 0;

    for @$ints -> UInt $int
    {
        $element-sum += $int;
        $digit-sum   += $_ for $int.split: '', :skip-empty;
    }

    return ($element-sum - $digit-sum).abs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $expected) = $line.split: / \| /;

        for     $test-name, $int-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints     = $int-str.split( / \s+ /, :skip-empty )
                                    .map: { .Int };
        my UInt $sum-diff = find-sum-diff( @ints );

        is $sum-diff, $expected.Int, $test-name;
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
        Example 1|1 23  4 5  |18
        Example 2|1  2  3 4 5| 0
        Example 3|1  2 34    |27
        Include 0|1 23  4 0 5|18
        END
}

################################################################################
