use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 349
=========================

TASK #1
-------
*Power String*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the power of the given string.

    The power of the string is the maximum length of a non-empty substring that
    contains only one unique character.

Example 1

  Input: $str = "textbook"
  Output: 2

  Breakdown: "t", "e", "x", "b", "oo", "k"
  The longest substring with one unique character is "oo".

Example 2

  Input: $str = "aaaaa"
  Output: 5

Example 3

  Input: $str = "hoorayyy"
  Output: 3

  Breakdown: "h", "oo", "r", "a", "yyy"
  The longest substring with one unique character is "yyy".

Example 4

  Input: $str = "x"
  Output: 1

Example 5

  Input: $str = "aabcccddeeffffghijjk"
  Output: 4

  Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
  The longest substring with one unique character is "ffff".

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
2. A string is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 349, Task #1: Power String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $power = find-power( $str );

    "Output: $power".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-power( Str:D $str --> UInt:D )
#-------------------------------------------------------------------------------
{
    return 0 if $str eq '';

    my Match @matches = m:g/ (.) $0* / given $str;

    return [[&max]] @matches.map: { .chars };
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

        my $power = find-power( $str );

        is $power, $expected, $test-name;
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
        Example 1|textbook            |2
        Example 2|aaaaa               |5
        Example 3|hoorayyy            |3
        Example 4|x                   |1
        Example 5|aabcccddeeffffghijjk|4
        Empty    |                    |0
        END
}

################################################################################
