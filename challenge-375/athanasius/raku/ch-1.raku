use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 375
=========================

TASK #1
-------
*Single Common Word*

Submitted by: Mohammad Sajid Anwar

You are given two array of strings.

Write a script to return the number of strings that appear exactly once in each
of the two given arrays. String comparison is case sensitive.

Example 1

  Input: @array1 = ("apple", "banana", "cherry")
         @array2 = ("banana", "cherry", "date")
  Output: 2

Example 2

  Input: @array1 = ("a", "ab", "abc")
         @array2 = ("a", "a", "ab", "abc")
  Output: 2

  "a" appears once in @array1 but appears twice in @array2, therefore, not
  counted.

Example 3

  Input: @array1 = ("orange", "lemon")
         @array2 = ("grape", "melon")
  Output: 0

Example 4

  Input: @array1 = ("test", "test", "demo")
         @array2 = ("test", "demo", "demo")
  Output: 0

Example 5

  Input: @array1 = ("Hello", "world")
         @array2 = ("hello", "world")
  Output: 1

  String comparison is case sensitive.

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
2. Two strings are entered on the command-line. Each string contains a list of
   words separated by whitespace.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 375, Task #1: Single Common Word (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $array1,       #= A       whitespace-separated list of strings
    Str:D $array2        #= Another whitespace-separated list of strings
)
#===============================================================================
{
    my Str @array1 = $array1.split: / \s+ /, :skip-empty;
    my Str @array2 = $array2.split: / \s+ /, :skip-empty;

    "Input:  \@array1 = (%s)\n".printf: @array1.map( { qq["$_"] } ).join: ', ';
    "        \@array2 = (%s)\n".printf: @array2.map( { qq["$_"] } ).join: ', ';

    my UInt $count = count-single-common-words( @array1, @array2 );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-single-common-words
(
    List:D[Str:D] $array1,
    List:D[Str:D] $array2
--> UInt:D
)
#-------------------------------------------------------------------------------
{
    my UInt %dict1{Str};
          ++%dict1{ $_ } for @$array1;

    my UInt %dict2{Str};
          ++%dict2{ $_ } for @$array2;

    my UInt $count = 0;

    for %dict1.keys -> Str $key
    {
        ++$count if %dict1{ $key } == 1    &&
                   (%dict2{ $key }:exists) && %dict2{ $key } == 1;
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $array1, $array2, $expected) =
                $line.split: '|', :skip-empty;

        for     $test-name, $array1, $array2, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @array1 = $array1.split: / \s+ /, :skip-empty;
        my Str  @array2 = $array2.split: / \s+ /, :skip-empty;
        my UInt $count  = count-single-common-words( @array1, @array2 );

        is $count, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|apple banana cherry|banana cherry date|2
        Example 2|a ab abc           |a a ab abc        |2
        Example 3|orange lemon       |grape melon       |0
        Example 4|test test demo     |test demo demo    |0
        Example 5|Hello world        |hello world       |1
        END
}

################################################################################
