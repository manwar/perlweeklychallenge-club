use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 309
=========================

TASK #1
-------
*Min Gap*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, increasing order.

Write a script to return the element before which you find the smallest gap.

Example 1

  Input: @ints = (2, 8, 10, 11, 15)
  Output: 11

   8 - 2  => 6
  10 - 8  => 2
  11 - 10 => 1
  15 - 11 => 4

  11 is where we found the min gap.

Example 2

  Input: @ints = (1, 5, 6, 7, 14)
  Output: 6

   5 - 1 => 4
   6 - 5 => 1
   7 - 6 => 1
  14 - 7 => 7

  6 and 7 where we found the min gap, so we pick the first instance.

Example 3

  Input: @ints = (8, 20, 25, 28)
  Output: 28

   8 - 20 => 14
  25 - 20 => 5
  28 - 25 => 3

  28 is where we found the min gap.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The input list contains at least two elements.
2. "Increasing order" means *strictly* increasing order; therefore, the smallest
   possible gap is one.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 2 or more integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to signal that
   it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 309, Task #1: Min Gap (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of 2+ integers in strictly increasing order

    *@ints where { .elems > 1 && .all ~~ Int:D && are-increasing( @ints ) }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int $element = find-min-gap-elem( @ints );

    "Output: $element".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-gap-elem
(
    List:D[Int:D] $ints where { .elems > 1 && are-increasing( $ints ) }
--> Int:D
)
#-------------------------------------------------------------------------------
{
    my Int  $element      = $ints[ 1 ];
    my UInt $smallest-gap = $element - $ints[ 0 ];

    for 2 .. $ints.end -> UInt $i
    {
        my UInt $gap = $ints[ $i ] - $ints[ $i - 1 ];

        if $gap < $smallest-gap
        {
            $smallest-gap = $gap;
            $element      = $ints[ $i ];
        }
    }

    return $element;
}

#-------------------------------------------------------------------------------
sub are-increasing( List:D[Int:D] $ints where { .elems > 1 } --> Bool:D )
#-------------------------------------------------------------------------------
{
    for 1 .. $ints.end -> UInt $i
    {
        return False if $ints[ $i ] <= $ints[ $i - 1 ];
    }

    return True;
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

        my Int @ints    = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $element = find-min-gap-elem( @ints );

        is $element, $expected.Int, $test-name;
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
        Example 1|2  8 10 11 15|11
        Example 2|1  5  6  7 14| 6
        Example 3|8 20 25 28   |28
        END
}

################################################################################
