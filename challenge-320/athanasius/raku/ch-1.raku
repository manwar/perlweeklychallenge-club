use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 320
=========================

TASK #1
-------
*Maximum Count*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the maximum between the number of positive and negative
integers. Zero is neither positive nor negative.

Example 1

  Input: @ints = (-3, -2, -1, 1, 2, 3)
  Output: 3

  There are 3 positive integers.
  There are 3 negative integers.
  The maximum between 3 and 3 is 3.

Example 2

  Input: @ints = (-2, -1, 0, 0, 1)
  Output: 2

  There are 1 positive integers.
  There are 2 negative integers.
  The maximum between 2 and 1 is 2.

Example 3

  Input: @ints = (1, 2, 3, 4)
  Output: 4

  There are 4 positive integers.
  There are 0 negative integers.
  The maximum between 4 and 0 is 4.

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
3. If the first list element is negative, it must preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 320, Task #1: Maximum Count (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt $max-count = find-max-count( @ints );

    "Output: $max-count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-count( List:D[Int:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $pos = 0;
    my UInt $nil = 0;
    my UInt $neg = 0;

    for @$ints -> Int $int
    {
        my UInt $target := $int > 0 ?? $pos !! $int == 0 ?? $nil !! $neg;

        ++$target;
    }

    $pos + $nil + $neg == $ints.elems or die 'Logic error';       # Sanity check

    return ($pos, $neg).max;
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

        my Int  @ints      = $int-str.split( / \s+ /, :skip-empty )
                                     .map: { .Int };
        my UInt $max-count = find-max-count( @ints );

        is $max-count, $expected.Int, $test-name;
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
        Example 1|-3 -2 -1 1 2 3|3
        Example 2|-2 -1  0 0 1  |2
        Example 3| 1  2  3 4    |4
        END
}

################################################################################
