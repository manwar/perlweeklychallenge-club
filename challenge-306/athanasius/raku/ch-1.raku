use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 306
=========================

TASK #1
-------
*Odd Sum*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return the sum of all possible odd-length subarrays of the
given array. A subarray is a contiguous subsequence of the array.

Example 1

  Input: @ints = (2, 5, 3, 6, 4)
  Output: 77

  Odd length sub-arrays:
  (2) => 2
  (5) => 5
  (3) => 3
  (6) => 6
  (4) => 4
  (2, 5, 3) => 10
  (5, 3, 6) => 14
  (3, 6, 4) => 13
  (2, 5, 3, 6, 4) => 20

  Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77

Example 2

  Input: @ints = (1, 3)
  Output: 4

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
A "positive" integer is greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. One or more positive integers are entered on the command-line.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 306, Task #1: Odd Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of positive integers

    *@ints where { .elems > 0 && .all ~~ Pos:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt  $odd-sum = find-odd-sum( @ints );

    "Output: $odd-sum".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-odd-sum( List:D[Pos:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my $odd-sum = 0;

    for 0 .. $ints.end -> UInt $i
    {
        my UInt $sum   = 0;
        my UInt $count = 0;

        for $i .. $ints.end -> UInt $j
        {
            $sum     += $ints[ $j ];
            $odd-sum += $sum if ++$count % 2;
        }
    }

    return $odd-sum;
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

        my Pos  @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $sum  = find-odd-sum( @ints );

        is $sum, $expected.Int, $test-name;
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
        Example 1|2 5 3 6 4|77
        Example 2|1 3      | 4
        END
}

################################################################################
