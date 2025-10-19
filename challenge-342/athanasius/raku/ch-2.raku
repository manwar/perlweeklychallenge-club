use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 342
=========================

TASK #2
-------
*Max Score*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, containing 0 and 1 only.

Write a script to return the max score after splitting the string into two non-
empty substrings. The score after splitting a string is the number of zeros in
the left substring plus the number of ones in the right substring.

Example 1

  Input: $str = "0011"
  Output: 4

  1: left = "0", right = "011" => 1 + 2 => 3
  2: left = "00", right = "11" => 2 + 2 => 4
  3: left = "001", right = "1" => 2 + 1 => 3

Example 2

  Input: $str = "0000"
  Output: 3

  1: left = "0", right = "000" => 1 + 0 => 1
  2: left = "00", right = "00" => 2 + 0 => 2
  3: left = "000", right = "0" => 3 + 0 => 3

Example 3

  Input: $str = "1111"
  Output: 3

  1: left = "1", right = "111" => 0 + 3 => 3
  2: left = "11", right = "11" => 0 + 2 => 2
  3: left = "111", right = "1" => 0 + 1 => 1

Example 4

  Input: $str = "0101"
  Output: 3

  1: left = "0", right = "101" => 1 + 2 => 3
  2: left = "01", right = "01" => 1 + 1 => 2
  3: left = "010", right = "1" => 2 + 1 => 3

Example 5

  Input: $str = "011101"
  Output: 5

  1: left = "0", right = "11101" => 1 + 4 => 5
  2: left = "01", right = "1101" => 1 + 3 => 4
  3: left = "011", right = "101" => 1 + 2 => 3
  4: left = "0111", right = "01" => 1 + 1 => 2
  5: left = "01110", right = "1" => 2 + 1 => 3

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
2. A single string, at least 2 characters long, and comprising only the charac-
   ters "0" and "1", is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 342, Task #2: Max Score (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A 2+ character string containing only "0" and "1"

    Str:D $str where { / ^ <[ 0 1 ]> ** 2..* $ / }
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $max-score = find-max-score( $str );

    qq[Output: $max-score].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-score( Str:D $str where { / ^ <[ 0 1 ]> ** 2..* $ / } --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $max    = 0;
    my UInt @digits = $str.split( '', :skip-empty ).map: { .Int };
    my UInt $score  = [+] @digits;

    for 0 .. @digits.end - 1 -> UInt $i
    {
        $score += @digits[$i] ?? -1 !! 1;
        $max    = $score if $score > $max;
    }

    return $max;
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

        my UInt $max-score = find-max-score( $str );

        is $max-score, $expected.Int, $test-name;
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
        Example 1|0011  |4
        Example 2|0000  |3
        Example 3|1111  |3
        Example 4|0101  |3
        Example 5|011101|5
        END
}

################################################################################
