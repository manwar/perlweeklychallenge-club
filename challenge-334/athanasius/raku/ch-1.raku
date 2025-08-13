use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 334
=========================

TASK #1
-------
*Range Sum*

Submitted by: Mohammad Sajid Anwar

You are given a list integers and pair of indices..

Write a script to return the sum of integers between the given indices (inclu-
sive).

Example 1

  Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
  Output: 1

  Elements between indices (0, 2) => (-2, 0, 3)
  Range Sum: (-2) + 0 + 3 => 1

Example 2

  Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
  Output: -3

  Elements between indices (1, 3) => (-2, 3, -4)
  Range Sum: (-2) + 3 + (-4) => -3

Example 3

  Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
  Output: 2

  Elements between indices (3, 4) => (-1, 3)
  Range Sum: (-1) + 3 => 2

Example 4

  Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
  Output: -2

  Elements between indices (0, 3) => (-5, 4, -3, 2)
  Range Sum: (-5) + 4 + (-3) + 2 => -2

Example 5

  Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
  Output: 1

  Elements between indices (0, 2) => (-1, 0, 2)
  Range Sum: (-1) + 0 + 2 => 1

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
2. Indices x and y are entered on the command-line as named parameters, followed
   by a non-empty list of integers.
3. If the first integer in the list is negative, it must be preceded by "--" to
   indicate that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 334, Task #1: Range Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D :$x,                          #= First  index
    UInt:D :$y where { $y >= $x },       #= Second index
                                         #| A non-empty list of integers
        *@ints where { .elems > 0 && .all ~~ Int:D && @ints.end >= $y }
)
#===============================================================================
{
    "Input:  \@ints = (%s), \$x = $x, \$y = $y\n".printf: @ints.join: ', ';

    my Int $sum = find-range-sum( @ints, $x, $y );

    "Output: $sum".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-range-sum
(
    List:D[Int:D] $ints where { .elems > 0 },
    UInt:D        $x    where { $ints.end >= $x },
    UInt:D        $y    where { $ints.end >= $y && $y >= $x }
--> Int:D
)
#-------------------------------------------------------------------------------
{
    return [+] $ints[ $x .. $y ];
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $x, $y, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $x, $y, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $sum  = find-range-sum( @ints, $x.Int, $y.Int );

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
        Example 1|-2  0  3 -5  2 -1|0|2| 1
        Example 2| 1 -2  3 -4  5   |1|3|-3
        Example 3| 1  0  2 -1  3   |3|4| 2
        Example 4|-5  4 -3  2 -1  0|0|3|-2
        Example 5|-1  0  2 -3 -2  1|0|2| 1
        END
}

################################################################################
