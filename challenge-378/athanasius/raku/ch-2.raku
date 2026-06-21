use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 378
=========================

TASK #2
-------
*Sum of Words*

Submitted by: Mohammad Sajid Anwar

You are given three strings consisting of lower case English letters 'a' to 'j'
only. The letter value of a = 0, b = 1, c = 3, etc.

Write a script to find if sum of first two strings return the third string.

Example 1

  Input: $str1 = "acb", $str2 = "cba", $str3 = "cdb"
  Output: true

  $str1 = "acb" = 021
  $str2 = "cba" = 210
  $str3 = "cdb" = 231
  $str1 + $str2 = $str3

Example 2

  Input: $str1 = "aab", $str2 = "aac", $str3 = "ad"
  Output: true

  $str1 = "aab" = 001
  $str2 = "aac" = 002
  $str3 = "ad"  = 03

Example 3

  Input: $str1 = "bc", $str2 = "je", $str3 = "jg"
  Output: false

  $str1 = "bc" = 12
  $str2 = "je" = 94
  $str3 = "jg" = 96

Example 4

  Input: $str1 = "a", $str2 = "aaaa", $str3 = "aa"
  Output: true

  $str1 = "a"    = 0
  $str2 = "aaaa" = 0000
  $str3 = "aa"   = 00

Example 5

  Input: $str1 = "c", $str2 = "d", $str3 = "h"
  Output: false

  $str1 = "c" = 2
  $str2 = "d" = 3
  $str3 = "h" = 7

Example 6

  Input: $str1 = "gfi", $str2 = "hbf", $str3 = "bdhd"
  Output: true

  $str1 =  "gfi" =  658
  $str2 =  "hbf" =  715
  $str3 = "bdhd" = 1373

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
2. Three strings, each consisting of lower case English letters 'a' to 'j' only,
   are entered on the command-line.

Assumption
----------
The input strings are not empty.

=end comment
#===============================================================================

use Test;

subset Word of Str where * ~~ / ^ <[ a .. j ]>+ $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 378, Task #2: Sum of Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Word:D $str1,          #= 1st string ('a' to 'j' only, non-empty)
    Word:D $str2,          #= 2nd string ('a' to 'j' only, non-empty)
    Word:D $str3           #= 3rd string ('a' to 'j' only, non-empty)
)
#===============================================================================
{
    qq[Input:  \$str1 = "$str1", \$str2 = "$str2", \$str3 = "$str3"].put;

    my Bool $sum = words-sum( $str1, $str2, $str3 );

    "Output: %s\n".printf: $sum ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub words-sum
(
    Word:D $str1,              #= First  string ('a' to 'j' only)
    Word:D $str2,              #= Second string ('a' to 'j' only)
    Word:D $str3               #= Third  string ('a' to 'j' only)
--> Bool:D
)
#-------------------------------------------------------------------------------
{
    my UInt @vals;

    for $str1, $str2, $str3 -> Word $str
    {
        @vals.push: TR/a..j/0..9/.Int with $str;
    }

    return @vals[0] + @vals[1] == @vals[2];
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str1, $str2, $str3, $expected) = $line.split: '|';

        for     $test-name, $str1, $str2, $str3, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $sum = words-sum( $str1, $str2, $str3 ) ?? 'true' !! 'false';

        is $sum, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|acb| cba| cdb|true
        Example 2|aab| aac|  ad|true
        Example 3| bc|  je|  jg|false
        Example 4|  a|aaaa|  aa|true
        Example 5|  c|   d|   h|false
        Example 6|gfi| hbf|bdhd|true
        END
}

################################################################################
