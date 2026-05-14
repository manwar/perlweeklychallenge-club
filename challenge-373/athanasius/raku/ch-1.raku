use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 373
=========================

TASK #1
-------
*Equal List*

Submitted by: Mohammad Sajid Anwar

You are given two arrays of strings.

Write a script to return true if the two given array represent the same strings
otherwise false.

Example 1

  Input: @arr1 = ("a", "bc")
         @arr2 = ("ab", "c")
  Output: true

  Array 1: "a" + "bc" = "abc"
  Array 2: "ab" + "c" = "abc"

Example 2

  Input: @arr1 = ("a", "b", "c")
         @arr2 = ("a", "bc")
  Output: true

  Array 1: "a" + "b" + "c" = "abc"
  Array 2: "a" + "bc" = "abc"

Example 3

  Input: @arr1 = ("a", "bc")
         @arr2 = ("a", "c", "b")
  Output: false

  Array 1: "a" + "bc" = "abc"
  Array 2: "a" + "c" + "b" = "acb"

Example 4

  Input: @arr1 = ("ab", "c", "")
         @arr2 = ("", "a", "bc")
  Output: true

  Array 1: "ab" + "c" + "" = "abc"
  Array 2: ""  + "a" + "bc" = "abc"

Example 5

  Input: @arr1 = ("p", "e", "r", "l")
         @arr2 = ("perl")
  Output: true

  Array 1: "p" + "e" + "r" + "l" = "perl"
  Array 2: "perl"

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
2. Two strings are entered on the command-line. Each comprises a list of strings
   (possibly empty) separated by pipe ("|") characters.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 373, Task #1: Equal List (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $arr1,         #= A string comprising a pipe-separated list of strings
    Str:D $arr2          #= A string comprising a pipe-separated list of strings
)
#===============================================================================
{
    my Str @arr1 = $arr1.split: '|';
    my Str @arr2 = $arr2.split: '|';

    qq[Input:  \@arr1 = (%s)\n].printf: @arr1.map( { qq["$_"] } ).join: ', ';
    qq[        \@arr2 = (%s)\n].printf: @arr2.map( { qq["$_"] } ).join: ', ';

    my Bool $equal = lists-are-equal( @arr1, @arr2 );

    qq[Output: %s\n].printf: $equal ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub lists-are-equal( List:D[Str:D] $arr1, List:D[Str:D] $arr2 --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str $str1 = $arr1.join;
    my Str $str2 = $arr2.join;

    return $str1 eq $str2;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $arr1, $arr2, $expected) = $line.split: '|';

        $test-name ~~ s/ \s+ $ //;

        my Str @arr1  = $arr1.split: ':';
        my Str @arr2  = $arr2.split: ':';
        my Str $equal = lists-are-equal( @arr1, @arr2 ) ?? 'true' !! 'false';

        is $equal, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|a:bc|ab:c|true
        Example 2|a:b:c|a:bc|true
        Example 3|a:bc|a:c:b|false
        Example 4|ab:c:|:a:bc|true
        Example 5|p:e:r:l|perl|true
        END
}

################################################################################
