use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 371
=========================

TASK #2
-------
*Subset Equilibrium*

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers.

Write a script to find all proper subsets with more than one element where the
sum of elements equals the sum of their indices.

Example 1

  Input: @nums = (2, 1, 4, 3)
  Output: (2, 1), (1, 4), (4, 3), (2, 3)

  Subset 1: (2, 1)
  Values: 2 + 1 = 3
  Positions: 1 + 2 = 3

  Subset 2: (1, 4)
  Values: 1 + 4 = 5
  Positions: 2 + 3 = 5

  Subset 3: (4, 3)
  Values: 4 + 3 = 7
  Positions: 3 + 4 = 7

  Subset 4: (2, 3)
  Values: 2 + 3 = 5
  Positions: 1 + 4 = 5

Example 2

  Input: @nums = (3, 0, 3, 0)
  Output: (3, 0), (3, 0, 3)

  Subset 1: (3, 0)
  Values: 3 + 0 = 3
  Positions: 1 + 2 = 3

  Subset 2: (3, 0, 3)
  Values: 3 + 0 + 3 = 6
  Positions: 1 + 2 + 3 = 6

Example 3

  Input: @nums = (5, 1, 1, 1)
  Output: (5, 1, 1)

  Subset 1: (5, 1, 1)
  Values: 5 + 1 + 1 = 7
  Positions: 1 + 2 + 4 = 7

Example 4

  Input: @nums = (3, -1, 4, 2)
  Output: (3, 2), (3, -1, 4)

  Subset 1: (3, 2)
  Values: 3 + 2 = 5
  Positions: 1 + 4 = 5

  Subset 2: (3, -1, 4)
  Values: 3 + (-1) + 4 = 6
  Positions: 1 + 2 + 3 = 6

Example 5

  Input: @nums = (10, 20, 30, 40)
  Output: ()

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
3. If the first number is negative, it must be preceded by "--" to indicate that
   it is not a command-line flag.

Assumptions
-----------
1. The input numbers are integers.
2. Within the solution, subsets are ordered by cardinal number, ascending. With-
   in each group with the same cardinal number, subsets are ordered by first in-
   dex, then by second index, etc., all ascending. Therefore the solution given
   in Example 1 is wrongly ordered; it should be:

     Input: @nums = (2, 1, 4, 3)
     Output: (2, 1), (2, 3), (1, 4), (4, 3)

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 371, Task #2: Subset Equilibrium (Raku)\n".put;
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

    my Array[Int] @subsets = find-subsets( @nums );

    "Output: %s\n".printf: @subsets.elems == 0 ?? '()' !!
                   @subsets.map( { '(' ~ @$_.join( ', ' ) ~ ')' } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-subsets( List:D[Int:D] $nums --> List:D[List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Int] @subsets = Array[Int].new;

    for (0 .. $nums.end).combinations( 2 .. $nums.elems - 1 ) -> List $comb
    {
        my Int  $value-sum    = [+] $nums[ @$comb ];
        my UInt $position-sum = [+] @$comb.map: { $_ + 1 };

        if $value-sum == $position-sum
        {
            @subsets.push: Array[Int].new: $nums[ @$comb ];
        }
    }

    return @subsets;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $nums-str, @exp-strs) =
                $line.split: / \| /, :skip-empty;

        for     $test-name, $nums-str, @exp-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @nums = $nums-str.split( / \s+ /, :skip-empty ).map: { .Int };

        my Array[Int] @subsets = find-subsets( @nums );
        my Array[Int] @expected;

        for @exp-strs -> Str $exp-str
        {
            @expected.push: Array[Int].new:
                $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };
        }

        is-deeply @subsets, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1| 2  1  4  3|2 1|2 3|1 4|4 3
        Example 2| 3  0  3  0|3 0|3 0 3
        Example 3| 5  1  1  1|5 1 1
        Example 4| 3 -1  4  2|3 2|3 -1 4
        Example 5|10 20 30 40|
        END
}

################################################################################
