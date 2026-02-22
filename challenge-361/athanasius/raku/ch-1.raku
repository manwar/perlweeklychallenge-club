use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 361
=========================

TASK #1
-------
*Zeckendorf Representation*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer (<= 100).

Write a script to return Zeckendorf Representation of the given integer.

    Every positive integer can be uniquely represented as sum of non-consecutive
    Fibonacci numbers.

Example 1

  Input: $int = 4
  Output: 3,1

  4 => 3 + 1 (non-consecutive fibonacci numbers)

Example 2

  Input: $int = 12
  Output: 8,3,1

  12 => 8 + 3 + 1

Example 3

  Input: $int = 20
  Output: 13,5,2

  20 => 13 + 5 + 2

Example 4

  Input: $int = 96
  Output: 89,5,2

  96 => 89 + 5 + 2

Example 5

  Input: $int = 100
  Output: 89,8,3

  100 => 89 + 8 + 3

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
2. A positive (non-zero) integer not greater than 100 is entered on the command-
   line.

=end comment
#===============================================================================

use Test;

constant @FIBONACCI = Array[UInt].new: 1, 2, 3, 5, 8, 13, 21, 34, 55, 89;

my UInt constant $MAX-INT = 100;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 361, Task #1: Zeckendorf Representation (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| An integer between 1 and 100

    Int:D $int where 1 <= * <= $MAX-INT
)
#===============================================================================
{
    "Input:  \$int = $int".put;

    my UInt @zeckendorf = find-zeckendorf-rep( $int );

    "Output: %s\n".printf: @zeckendorf.join: ',';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-zeckendorf-rep
(
    Int:D $int where 1 <= * <= $MAX-INT
--> List:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    my UInt @zeckendorf;
    my UInt $index     = @FIBONACCI.end;
    my UInt $remaining = $int;

    while $remaining > 0
    {
        --$index until @FIBONACCI[$index] <= $remaining;

        my UInt $fib = @FIBONACCI[$index];

        @zeckendorf.push: $fib;
        $remaining   -=   $fib;
    }

    return @zeckendorf;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int, $expected) = $line.split: / \| /;

        for     $test-name, $int, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @zeckendorf = find-zeckendorf-rep( $int.Int );
        my UInt @expected   = $expected.split( ',', :skip-empty ).map: { .Int };

        is-deeply @zeckendorf, @expected, $test-name;
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
        Example 1|  4|   3,1
        Example 2| 12| 8,3,1
        Example 3| 20|13,5,2
        Example 4| 96|89,5,2
        Example 5|100|89,8,3
        END
}

################################################################################
