use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 263
=========================

TASK #1
-------
*Target Index*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and a target element $k.

Write a script to return the list of indices in the sorted array where the
element is same as the given target element.

Example 1

  Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
  Output: (1, 2)

  Sorted array: (1, 2, 2, 3, 4, 5)
  Target indices: (1, 2) as $ints[1] = 2 and $k[2] = 2

Example 2

  Input: @ints = (1, 2, 4, 3, 5), $k = 6
  Output: ()

  No element in the given array matching the given target.

Example 3

  Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
  Output: (4)

  Sorted array: (1, 2, 2, 3, 4, 5)
  Target index: (4) as $ints[4] = 4

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
2. The divisor $k is given on the command-line as a named argument, followed by
   a (possibly empty) unnamed list of integers.
3. If the first integer in the list (i.e., following $k) on the command-line is
   negative, it must be preceded by "--" to indicate that it is not a command-
   line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 263, Task #1: Target Index (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Int:D :$k,                                   #= The target element
          *@ints where { .all ~~ Int:D }         #= A list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s), \$k = %d\n".printf: @ints.join( ', ' ), $k;

    my UInt @indices = find-target-indices( @ints, $k );

    "Output: (%s)\n".printf: @indices.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-target-indices( List:D[Int:D] $ints, Int:D $k --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @indices;
    my Int  @sorted = $ints.sort;

    for 0 .. @sorted.end -> UInt $i
    {
        @indices.push: $i if @sorted[ $i ] == $k;
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
        my Str ($test-name, $ints-str, $k-str, $expd-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $k-str, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @expd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @inds = find-target-indices( @ints, $k-str.Int );

        is-deeply @inds, @expd, $test-name;
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
        Example 1| 1  5  3 2 4  2| 2|1 2
        Example 2| 1  2  4 3 5   | 6|
        Example 3| 5  3  2 4 2  1| 4|4
        Negatives|-1 -2 -3 0 4 -3|-3|0 1
        END
}

################################################################################
