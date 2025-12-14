use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 351
=========================

TASK #1
-------
*Special Average*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the average excluding the minimum and maximum of the
given array.

Example 1

  Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
  Output: 5250

  Min: 2000
  Max: 8000
  Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250

Example 2

  Input: @ints = (100_000, 80_000, 110_000, 90_000)
  Output: 95_000

  Min: 80_000
  Max: 110_000
  Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000

Example 3

  Input: @ints = (2500, 2500, 2500, 2500)
  Output: 0

  Min: 2500
  Max: 2500
  Avg: 0

Example 4

  Input: @ints = (2000)
  Output: 0

  Min: 2000
  Max: 2000
  Avg: 0

Example 5

  Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
  Output: 3500

  Min: 1000
  Max: 6000
  Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
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

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 351, Task #1: Special Average (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Real $average = find-special-average( @ints );

    "Output: $average".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-special-average( List:D[Int:D] $ints --> Real:D )
#-------------------------------------------------------------------------------
{
    my Real $average = 0;

    if $ints.elems > 2
    {
        my Int @sorted = $ints.sort;
        my Int $min    = @sorted[  0];
        my Int $max    = @sorted[*-1];

        @sorted.shift while @sorted.elems > 0 && @sorted[  0] == $min;
        @sorted.pop   while @sorted.elems > 0 && @sorted[*-1] == $max;

        if @sorted.elems > 0
        {
            my Int $sum = [+] @sorted;
            $average    = $sum / @sorted.elems;
        }
    }

    return $average;
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

        my Int  @ints    = $ints-str.split( / \s+ / ).map: { .Int };
        my Real $average = find-special-average( @ints );

        is $average, $expected.Real, $test-name;
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
        Example 1|  8000  5000   6000  2000 3000 7000| 5250
        Example 2|100000 80000 110000 90000          |95000
        Example 3|  2500  2500   2500  2500          |    0
        Example 4|  2000                             |    0
        Example 5|  1000  2000   3000  4000 5000 6000| 3500
        END
}

################################################################################
