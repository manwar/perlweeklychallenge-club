use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 365
=========================

TASK #1
-------
*Alphabet Index Digit Sum*

Submitted by: Mohammad Sajid Anwar

You are given a string $str consisting of lowercase English letters, and an
integer $k.

Write a script to convert a lowercase string into numbers using alphabet
positions (a=1 … z=26), concatenate them to form an integer, then compute the
sum of its digits repeatedly $k times, returning the final value.

Example 1

  Input: $str = "abc", $k = 1
  Output: 6

  Conversion: a = 1, b = 2, c = 3 -> 123
  Digit sum: 1 + 2 + 3 = 6

Example 2

  Input: $str = "az", $k = 2
  Output: 9

  Conversion: a = 1, z = 26 -> 126
  1st sum: 1 + 2 + 6 = 9
  2nd sum: 9

Example 3

  Input: $str = "cat", $k = 1
  Output: 6

  Conversion: c = 3, a = 1, t = 20 -> 3120
  Digit sum: 3 + 1 + 2 + 0 = 6

Example 4

  Input: $str = "dog", $k = 2
  Output: 8

  Conversion: d = 4, o = 15, g = 7 -> 4157
  1st sum: 4 + 1 + 5 + 7 = 17
  2nd sum: 1 + 7 = 8

Example 5

  Input: $str = "perl", $k = 3
  Output: 6

  Conversion: p = 16, e = 5, r = 18, l = 12 -> 1651812
  1st sum: 1 + 6 + 5 + 1 + 8 + 1 + 2 = 24
  2nd sum: 2+4 = 6
  3rd sum: 6

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. $k is a positive (i.e., unsigned) integer.
2. If $k = 0 then the concatenated digits are not summed at all.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string of lowercase English letters is entered on the command-line, follow-
   ed by an unsigned integer.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 365, Task #1: Alphabet Index Digit Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D  $str where { / ^ <[ a .. z ]>* $ / },    #= A string of lowercase
                                                    #=   English letters
    UInt:D $k                                       #= An unsigned integer
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$k = $k].put;

    my UInt $sum = find-digit-sum( $str, $k );

    "Output: $sum".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-digit-sum
(
    Str:D  $str where { / ^ <[ a .. z ]>* $ / },    #= A string of lowercase
                                                    #=   English letters
    UInt:D $k                                       #= An unsigned integer
--> UInt:D
)
#-------------------------------------------------------------------------------
{
    my Str $int = '';

    for $str.split( '', :skip-empty ) -> Str $chr
    {
        $int ~= $chr.ord - 'a'.ord + 1;
    }

    my Int $kk = $k;

    until (0 >= $kk-- || $int.chars == 1)
    {
        my UInt $sum = [+] $int.split: '', :skip-empty;

        $int = ~$sum;
    }

    return $int.Int;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $k, $expected) = $line.split: / \| /;

        for     $test-name, $str, $k, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $sum = find-digit-sum( $str, $k.Int );

        is $sum, $expected, $test-name;
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
        Example 1|abc        |1|          6
        Example 2|az         |2|          9
        Example 3|cat        |1|          6
        Example 4|dog        |2|          8
        Example 5|perl       |3|          6
        Big sum 0|iiiiiiiiiii|0|99999999999
        Big sum 1|iiiiiiiiiii|1|         99
        Big sum 2|iiiiiiiiiii|2|         18
        Big sum 5|iiiiiiiiiii|5|          9
        END
}

################################################################################
