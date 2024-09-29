use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 288
=========================

TASK #1
-------
*Closest Palindrome*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, which is an integer.

Write a script to find out the closest palindrome, not including itself. If
there are more than one then return the smallest.

    The closest is defined as the absolute difference minimized between two
    integers.

Example 1

  Input: $str = "123"
  Output: "121"

Example 2

  Input: $str = "2"
  Output: "1"

  There are two closest palindrome "1" and "3". Therefore we return the smallest
  "1".

Example 3

  Input: $str = "1400"
  Output: "1441"

Example 4

  Input: $str = "1001"
  Output: "999"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The input integer is unsigned (non-negative).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string representing an unsigned integer is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 288, Task #1: Closest Palindrome (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                      #= A string representing an unsigned integer
)
#===============================================================================
{
    $str ~~ Int:D or error( qq["$str" is not a valid integer] );

    my Int $int = +$str;

    $int >= 0     or error( "$int is negative" );

    print qq[Input: \$str = "$int"\n];

    my UInt $closest-palindrome = find-closest-palindrome( $int );

    print qq[Output:       "$closest-palindrome"\n];
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-closest-palindrome( UInt:D $int --> UInt:D )
#-------------------------------------------------------------------------------
{
    return 1 if $int == 0;

    my UInt $above = $int + 1;
          ++$above until is-palindrome( $above );

    my UInt $below = $int - 1;
          --$below until is-palindrome( $below );

    my UInt $above-diff = $above - $int;
    my UInt $below-diff = $int - $below;

    return ($above-diff < $below-diff) ?? $above !! $below;
}

#-------------------------------------------------------------------------------
sub is-palindrome( UInt:D $int --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt @digits = $int.split( '', :skip-empty ).map: { .Int };

    for 0 .. (@digits.end / 2).floor -> UInt $i
    {
        return False unless @digits[ $i ] == @digits[ @digits.end - $i ];
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
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $closest-palindrome = find-closest-palindrome( $str.Int );

        is $closest-palindrome, $expected.Int, $test-name;
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
        Example 1|    123|   121
        Example 2|      2|     1
        Example 3|   1400|  1441
        Example 4|   1001|   999
        Zero     |      0|     1
        One      |      1|     0
        1 Million|1000000|999999
        Odd      |  12721| 12621
        END
}

################################################################################
