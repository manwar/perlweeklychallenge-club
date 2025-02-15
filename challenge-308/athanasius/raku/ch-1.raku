use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 308
=========================

TASK #1
-------
*Count Common*

Submitted by: Mohammad Sajid Anwar

You are given two array of strings, @str1 and @str2.

Write a script to return the count of common strings in both arrays.

Example 1

  Input: @str1 = ("perl", "weekly", "challenge")
         @str2 = ("raku", "weekly", "challenge")
  Output: 2

Example 2

  Input: @str1 = ("perl", "raku", "python")
         @str2 = ("python", "java")
  Output: 1

Example 3

  Input: @str1 = ("guest", "contribution")
         @str2 = ("fun", "weekly", "challenge")
  Output: 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. String comparisons are case-sensitive.
2. If a string appears, say, twice in @str1 and three times in @str2, this adds
   only one to the count of strings common to both arrays.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. Each string is a whitespace-
   separated list of words.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 308, Task #1: Count Common (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str $str1,           #= First  whitespace-separated list of words
    Str $str2            #= Second whitespace-separated list of words
)
#===============================================================================
{
    my @str1 = $str1.split: / \s+ /, :skip-empty;
    my @str2 = $str2.split: / \s+ /, :skip-empty;

    "Input:  \@str1 = (%s)\n".printf: @str1.map( { qq["$_"] } ).join: ', ';
    "        \@str2 = (%s)\n".printf: @str2.map( { qq["$_"] } ).join: ', ';

    my UInt  $common = count-common( @str1, @str2 );

    "Output: $common".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-common( List:D[Str:D] $str1, List:D[Str:D] $str2 --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt %dict1{Str};
          ++%dict1{ $_ } for @$str1;

    my UInt %dict2{Str};
          ++%dict2{ $_ } for @$str2;

    my UInt $common = 0;
          ++$common if %dict1{ $_ }:exists for %dict2.keys;

    return  $common;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str1, $str2, $expected) = $line.split: / \| /;

        for     $test-name, $str1, $str2, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @str1   = $str1.split: / \s+ /, :skip-empty;
        my Str  @str2   = $str2.split: / \s+ /, :skip-empty;
        my UInt $common = count-common( @str1, @str2 );

        is $common, $expected.Int, $test-name;
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
        Example 1|perl weekly challenge|raku weekly challenge     |2
        Example 2|perl raku python     |python java               |1
        Example 3|guest contribution   |fun weekly challenge      |0
        Multiples|perl raku perl java  |perl fortran perl c++ perl|1
        Case     |perl raku c++ java   |Perl Raku c++ Java        |1
        END
}

################################################################################
