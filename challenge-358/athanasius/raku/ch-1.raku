use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 358
=========================

TASK #1
-------
*Max Str Value*

Submitted by: Mohammad Sajid Anwar

You are given an array of alphanumeric string, @strings.

Write a script to find the max value of alphanumeric string in the given array.
The numeric representation of the string, if it comprises of digits only other-
wise length of the string.

Example 1

  Input: @strings = ("123", "45", "6")
  Output: 123

  "123" -> 123
  "45"  -> 45
  "6"   -> 6

Example 2

  Input: @strings = ("abc", "de", "fghi")
  Output: 4

  "abc"  -> 3
  "de"   -> 2
  "fghi" -> 4

Example 3

  Input: @strings = ("0012", "99", "a1b2c")
  Output: 99

  "0012"  -> 12
  "99"    -> 99
  "a1b2c" -> 5

Example 4

  Input: @strings = ("x", "10", "xyz", "007")
  Output: 10

  "x"   -> 1
  "xyz" -> 3
  "007" -> 7
  "10"  -> 10

Example 5

  Input: @strings = ("hello123", "2026", "perl")
  Output: 2026

  "hello123" -> 8
  "perl"     -> 4
  "2026"     -> 2026

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
2. A non-empty list of alphanumeric strings is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset AlphaNum of Str where * ~~ / ^ <[ A..Z a..z 0..9 ]>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 358, Task #1: Max Str Value (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of alphanumeric strings

    *@strings where { .elems > 0 && .all ~~ AlphaNum:D }
)
#===============================================================================
{
    "Input:  \@strings = %s\n".printf: @strings.map( { qq["$_"] } ).join: ', ';

    my UInt $max = find-max-str-value( @strings );

    "Output: $max".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-str-value( List:D[AlphaNum:D] $strings --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $max-value = 0;

    for @$strings -> AlphaNum $string
    {
        my UInt $value = $string ~~ / \D / ?? $string.chars !! +$string;

        $max-value = $value if $value > $max-value;
    }

    return $max-value;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $strings, $expected) = $line.split: / \| /;

        for     $test-name, $strings, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @strings = $strings.split: / \s+ /, :skip-empty;
        my UInt $max     = find-max-str-value( @strings );

        is $max, $expected.Int, $test-name;
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
        Example 1|123 45 6          | 123
        Example 2|abc de fghi       |   4
        Example 3|0012 99 a1b2c     |  99
        Example 4|x 10 xyz 007      |  10
        Example 5|hello123 2026 perl|2026
        END
}

################################################################################
