use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 377
=========================

TASK #1
-------
*Reverse Existence*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find whether any substring of length 2 is also present in the
reverse of the given string.

Example 1

  Input: $str = "abcba"
  Output: true

  Reverse of given string is "abcba".
  The substring "ab" in original string is also present in the reverse string
  too.

Example 2

  Input: $str = "racecar"
  Output: true

  The substring "ce" is present in both.

Example 3

  Input: $str = "abcd"
  Output: false

Example 4

  Input: $str = "banana"
  Output: true

  The substring "an" is present in both.

Example 5

  Input: $str = "hello"
  Output: true

  The substring "ll" is present in both.

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
2. A single string is entered on the command-line.

Assumption
----------
Comparisons are case-sensitive.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 377, Task #1: Reverse Existence (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Bool $reverse-exists = reverse-exists( $str );

    "Output: %s\n".printf: $reverse-exists ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub reverse-exists( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %dict{Str};

    for $str ~~ m:ov/ .. / -> Match $match
    {
        my Str $substr = ~$match;

        return True if $substr ~~ / (.) $0 /;

        ++%dict{ $substr };
    }

    for %dict.keys -> Str $key
    {
        return True if %dict{ $key.flip }:exists;
    }

    return False;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: '|';

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $reverse-exists = reverse-exists( $str ) ?? 'true' !! 'false';

        is $reverse-exists, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|abcba  |true
        Example 2|racecar|true
        Example 3|abcd   |false
        Example 4|banana |true
        Example 5|hello  |true
        END
}

################################################################################
