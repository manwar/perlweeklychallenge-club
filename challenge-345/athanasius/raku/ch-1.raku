use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 345
=========================

TASK #1
-------
*Peak Positions*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Find all the peaks in the array, a peak is an element that is strictly greater
than its left and right neighbours. Return the indices of all such peak posi-
tions.

Example 1

  Input: @ints = (1, 3, 2)
  Output: (1)

Example 2

  Input: @ints = (2, 4, 6, 5, 3)
  Output: (2)

Example 3

  Input: @ints = (1, 2, 3, 2, 4, 1)
  Output: (2, 4)

Example 4

  Input: @ints = (5, 3, 1)
  Output: (0)

Example 5

  Input: @ints = (1, 5, 1, 5, 1, 5, 1)
  Output: (1, 3, 5)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
From Example 4, it appears that an integer in either end position is considered
to be "strictly greater than" its non-existent neighbour.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to signal that
   it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 345, Task #1: Peak Positions (Raku)\n".put;
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

    my UInt @peaks = find-peaks( @ints );

    "Output: (%s)\n".printf: @peaks.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-peaks( List:D[Int:D] $ints where { .elems > 0 } --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @peaks;

    if $ints.elems == 1
    {
        @peaks.push: 0;
    }
    else
    {
        my UInt $e = $ints.end;

        @peaks.push: 0      if $ints[0]  > $ints[1];

        for 1 .. $e - 1 -> UInt $i
        {
            @peaks.push: $i if $ints[$i] > $ints[$i - 1] &&
                               $ints[$i] > $ints[$i + 1]
        }

        @peaks.push: $e     if $ints[$e] > $ints[$e - 1];
    }

    return @peaks;
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

        my Int  @ints  = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @peaks = find-peaks( @ints );
        my UInt @expd  = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @peaks, @expd, $test-name;
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
        Example 1|1 3 2        |1
        Example 2|2 4 6 5 3    |2
        Example 3|1 2 3 2 4 1  |2 4
        Example 4|5 3 1        |0
        Example 5|1 5 1 5 1 5 1|1 3 5
        Singleton|4            |0
        Negatives|0 -1 1 -2 0  |0 2 4
        END
}

################################################################################
