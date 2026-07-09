use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 381
=========================

TASK #2
-------
*Smaller Greater Element*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to find the number of elements that have both a strictly smaller
and greater element in the given array.

Example 1

  Input: @int = (2,4)
  Output: 0

  Not enough elements in the array.

Example 2

  Input: @int = (1, 1, 1, 1)
  Output: 0

Example 3

  Input: @int = (1, 1, 4, 8, 12, 12)
  Output: 2

  The elements are 4 and 8.

Example 4

  Input: @int = (3, 6, 6, 9)
  Output: 2

  Both instances of 6.

Example 5

  Input: @int = (0, -5, 10, -2, 4)
  Output: 3

  The elements are 0, -2, and 4.

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
3. If the first integer is negative, it must be preceded by "--" to distinguish
   it from a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 381, Task #2: Smaller Greater Element (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@int where { .elems > 0 && .all ~~ Int:D }  #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@int = (%s)\n".printf: @int.join: ', ';

    my UInt $count = count-elements( @int );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-elements( List:D[Int:D] $int --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count  = 0;
    my Int  @sorted = $int.sort;
    my Int  @unique = @sorted.unique;

    if @unique.elems > 2
    {
        my Int $min = @unique[  0];
        my Int $max = @unique[*-1];

        @sorted.shift while @sorted[  0] == $min;
        @sorted.pop   while @sorted[*-1] == $max;

        $count = @sorted.elems;
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $expected) = $line.split: '|';

        for     $test-name, $int-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @int   = $int-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $count = count-elements( @int );

        is $count, $expected.Int, $test-name;
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
        Example 1|2  4            |0
        Example 2|1  1  1  1      |0
        Example 3|1  1  4  8 12 12|2
        Example 4|3  6  6  9      |2
        Example 5|0 -5 10 -2  4   |3
        END
}

################################################################################
