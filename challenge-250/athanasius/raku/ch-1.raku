use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 250
=========================

TASK #1
-------
*Smallest Index*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to find the smallest index i such that i mod 10 == $ints[i]
otherwise return -1.

Example 1

  Input: @ints = (0, 1, 2)
  Output: 0

  i=0: 0 mod 10 = 0 == $ints[0].
  i=1: 1 mod 10 = 1 == $ints[1].
  i=2: 2 mod 10 = 2 == $ints[2].
  All indices have i mod 10 == $ints[i], so we return the smallest index 0.

Example 2

  Input: @ints = (4, 3, 2, 1)
  Output: 2

  i=0: 0 mod 10 = 0 != $ints[0].
  i=1: 1 mod 10 = 1 != $ints[1].
  i=2: 2 mod 10 = 2 == $ints[2].
  i=3: 3 mod 10 = 3 != $ints[3].
  2 is the only index which has i mod 10 == $ints[i].

Example 3

  Input: @ints = (1, 2, 3, 4, 5, 6, 7, 8, 9, 0)
  Output: -1
  Explanation: No index satisfies i mod 10 == $ints[i].

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
2. If the first command-line argument is negative, it must be preceded by "--"
   to distinguish it from a command-line switch.

Note
----
Negative numbers are allowed in the input. However, as array indices are never
negative, the expression i mod 10 is never negative, and so the equality
i mod 10 = ints[i] can never be satisfied when the array element ints[i] is
negative.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 250, Task #1: Smallest Index (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int $smallest-index = find-smallest-index( @ints );

    "Output: $smallest-index".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-smallest-index( List:D[Int:D] $ints --> Int:D )
#-------------------------------------------------------------------------------
{
    my Int $smallest-index = -1;

    for 0 .. $ints.end -> UInt $i
    {
        if $i % 10 == $ints[ $i ]
        {
            $smallest-index = $i;
            last;
        }
    }

    return $smallest-index;
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

        my Int @ints           = $ints-str.split( / \s+ / ).map: { .Int };
        my Int $smallest-index = find-smallest-index( @ints );

        is $smallest-index, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
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
        Example 1|0 1 2                 | 0
        Example 2|4 3 2   1             | 2
        Example 3|1 2 3   4 5  6 7 8 9 0|-1
        Negatives|1 2 3 -17 0 -5        |-1
        END
}

################################################################################
