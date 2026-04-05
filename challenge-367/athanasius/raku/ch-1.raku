use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 367
=========================

TASK #1
-------
*Max Odd Binary*

Submitted by: Mohammad Sajid Anwar

You are given a binary string that has at least one '1'.

Write a script to rearrange the bits in such a way that the resulting binary
number is the maximum odd binary number and return the resulting binary string.
The resulting string can have leading zeros.

Example 1

  Input: $str = "1011"
  Output: "1101"

  "1101" is max odd binary (13).

Example 2

  Input: $str = "100"
  Output: "001"

  "001" is max odd binary (1).

Example 3

  Input: $str = "111000"
  Output: "110001"

Example 4

  Input: $str = "0101"
  Output: "1001"

Example 5

  Input: $str = "1111"
  Output: "1111"

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
2. A binary string, containing at least one "1", is entered on the command-line.

Algorithm
---------
The first 1 is placed as the least significant digit, any remaining 1s are
placed as the most significant digits.

=end comment
#===============================================================================

use Test;

subset BinStr of Str where * ~~ / ^ <[ 0 1 ]>* $ / && * ~~ / 1 /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 367, Task #1: Max Odd Binary (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    BinStr:D $str,                #= A binary string containing at least one "1"
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my BinStr $max = find-max-odd-binary( $str );

    qq[Output: "$max"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-odd-binary( BinStr:D $str --> BinStr:D )
#-------------------------------------------------------------------------------
{
    my UInt $ones = $str.comb( / 1 / ).elems;

    return '1' x ($ones - 1) ~ '0' x ($str.chars - $ones) ~ '1';
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

        my BinStr $max = find-max-odd-binary( $str );

        is $max, $expected, $test-name;
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
        Example 1|  1011|  1101
        Example 2|   100|   001
        Example 3|111000|110001
        Example 4|  0101|  1001
        Example 5|  1111|  1111
        END
}

################################################################################
