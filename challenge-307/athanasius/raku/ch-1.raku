use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 307
=========================

TASK #1
-------
*Check Order*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to re-arrange the given array in an increasing order and return
the indices where it differs from the original array.

Example 1

  Input: @ints = (5, 2, 4, 3, 1)
  Output: (0, 2, 3, 4)

  Before: (5, 2, 4, 3, 1)
  After : (1, 2, 3, 4, 5)

  Difference at indices: (0, 2, 3, 4)

Example 2

  Input: @ints = (1, 2, 1, 1, 3)
  Output: (1, 3)

  Before: (1, 2, 1, 1, 3)
  After : (1, 1, 1, 2, 3)

  Difference at indices: (1, 3)

Example 3

  Input: @ints = (3, 1, 3, 2, 3)
  Output: (0, 1, 3)

  Before: (3, 1, 3, 2, 3)
  After : (1, 2, 3, 3, 3)

  Difference at indices: (0, 1, 3)

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
3. If the first integer in the list is negative, it must be preceded by "--" to
   indicate that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 307, Task #1: Check Order (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt @indices = find-diff-indices( @ints );

    "Output: (%s)\n".printf: @indices.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-diff-indices( List:D[Int:D] $ints --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my Int  @sorted = $ints.sort;
    my UInt @indices;

    for 0 .. $ints.end -> UInt $i
    {
        @indices.push: $i unless $ints[ $i ] == @sorted[ $i ];
    }

    return @indices;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expd-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @expd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @idxs = find-diff-indices( @ints );

        is-deeply @idxs, @expd, $test-name;
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
        Example 1 |5 2 4 3 1|0 2 3 4
        Example 2 |1 2 1 1 3|1 3
        Example 3 |3 1 3 2 3|0 1 3
        No changes|1 2 3 4 5|
        END
}

################################################################################
