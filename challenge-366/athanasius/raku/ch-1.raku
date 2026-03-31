use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 366
=========================

TASK #1
-------
*Count Prefixes*

Submitted by: Mohammad Sajid Anwar

You are given an array of words and a string (contains only lowercase English
letters).

Write a script to return the number of words in the given array that are a
prefix of the given string.

Example 1

  Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
  Output: 4

Example 2

  Input: @array = ("cat", "dog", "fish"), $str = "bird"
  Output: 0

Example 3

  Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
  Output: 4

Example 4

  Input: @array = ("", "code", "coding", "cod"), $str = "coding"
  Output: 3

Example 5

  Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"),
         $str = "program"
  Output: 7

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
2. A string of lowercase English letters is entered on the command-line, follow-
   ed by a list of words (also lowercase).

=end comment
#===============================================================================

use Test;

subset Str-lc of Str where * ~~ / ^ <[ a .. z ]>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 366, Task #1: Count Prefixes (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str-lc:D $str,                      #= A string of lowercase English letters

    *@array where { .all ~~ Str-lc:D }  #= A list of words (also lowercase)
)
#===============================================================================
{
    qq[Input:  \@array = (%s)\n].printf: @array.map( { qq["$_"] } ).join: ', ';
    qq[        \$str   =  "$str"].put;

    my UInt $count = count-prefixes( @array, $str );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-prefixes( List:D[Str-lc:D] $array, Str:D $str --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count   = 0;
    my UInt $str-len = $str.chars;

    for @$array -> Str-lc $word
    {
        my UInt $word-len = $word.chars;

        if $str-len >= $word-len
        {
            ++$count if $str.substr( 0, $word-len ) eq $word;
        }
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
        my Str ($test-name, $array-str, $str, $expected) = $line.split: / \| /;

        for     $test-name, $array-str, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str-lc @array = $array-str.split: / \; \s+ /;
        my UInt   $count = count-prefixes( @array, $str );

        is $count, $expected.Int, $test-name;
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
        Example 1|a; ap; app; apple; banana               |apple  |4
        Example 2|cat; dog; fish                          |bird   |0
        Example 3|hello; he; hell; heaven; he             |hello  |4
        Example 4|; code; coding; cod                     |coding |3
        Example 5|p; pr; pro; prog; progr; progra; program|program|7
        END
}

################################################################################
