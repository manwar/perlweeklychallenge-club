use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 267
=========================

TASK #1
-------
*Product Sign*

Submitted by: Mohammad Sajid Anwar

You are given an array of @ints.

Write a script to find the sign of product of all integers in the given array.
The sign is 1 if the product is positive, -1 if the product is negative and 0 if
product is zero.

Example 1

  Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
  Output: 1

  The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0

Example 2

  Input: @ints = (1, 2, 0, -2, -1)
  Output: 0

  The product 1 x 2 x 0 x -2 x -1 => 0

Example 3

  Input: @ints = (-1, -1, 1, -1, 2)
  Output: -1

  The product -1 x -1 x 1 x -1 x 2 => -2 < 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input integers are entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 267, Task #1: Product Sign (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int $sign = find-product-sign( @ints );

    "Output: $sign".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-product-sign( List:D[Int:D] $ints --> Int:D )
#-------------------------------------------------------------------------------
{
    my UInt $neg-count = 0;

    for @$ints -> Int $i
    {
        return 0     if $i == 0;
        ++$neg-count if $i <  0;
    }

    return $neg-count %% 2 ?? 1 !! -1;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $sign = find-product-sign( @ints );

        is $sign, $expected-str.Int, $test-name;
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
        Example 1|-1 -2 -3 -4  3  2  1| 1
        Example 2| 1  2  0 -2 -1      | 0
        Example 3|-1 -1  1 -1  2      |-1
        END
}

################################################################################
