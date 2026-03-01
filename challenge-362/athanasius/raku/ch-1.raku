use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 362
=========================

TASK #1
-------
*Echo Chamber*

Submitted by: Mohammad Sajid Anwar

You are given a string containing lowercase letters.

Write a script to transform the string based on the index position of each
character (starting from 0). For each character at position i, repeat it i + 1
times.

Example 1

  Input: "abca"
  Output: "abbcccaaaa"

  Index 0: "a" -> repeated 1 time  -> "a"
  Index 1: "b" -> repeated 2 times -> "bb"
  Index 2: "c" -> repeated 3 times -> "ccc"
  Index 3: "a" -> repeated 4 times -> "aaaa"

Example 2

  Input: "xyz"
  Output: "xyyzzz"

  Index 0: "x" -> "x"
  Index 1: "y" -> "yy"
  Index 2: "z" -> "zzz"
  
Example 3

  Input: "code"
  Output: "coodddeeee"

  Index 0: "c" -> "c"
  Index 1: "o" -> "oo"
  Index 2: "d" -> "ddd"
  Index 3: "e" -> "eeee"

Example 4

  Input: "hello"
  Output: "heelllllllooooo"

  Index 0: "h" -> "h"
  Index 1: "e" -> "ee"
  Index 2: "l" -> "lll"
  Index 3: "l" -> "llll"
  Index 4: "o" -> "ooooo"

Example 5

  Input: "a"
  Output: "a"

  Index 0: "a" -> "a"

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
2. A single, non-empty string of lowercase letters is entered on the command-
   line.

=end comment
#===============================================================================

use Test;

subset LowerCase of Str where * ~~ / ^ <:Ll>+ $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 362, Task #1: Echo Chamber (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    LowerCase:D $str              #= A string of lowercase letters
)
#===============================================================================
{
    qq[Input:  "$str"].put;

    my LowerCase $echoed-str = apply-echoes( $str );

    qq[Output: "$echoed-str"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub apply-echoes( LowerCase:D $str --> LowerCase:D )
#-------------------------------------------------------------------------------
{
    my LowerCase @chars = $str.split: '', :skip-empty;
    my LowerCase $echoed-str;

    for (0 .. @chars.end) -> UInt $i
    {
        $echoed-str ~= @chars[$i] x ($i + 1);
    }

    return $echoed-str;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $string, $expected) = $line.split: / \| /;

        for     $test-name, $string, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my LowerCase $echoed-str = apply-echoes( $string );

        is $echoed-str, $expected, $test-name;
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
        Example 1|abca |abbcccaaaa
        Example 2|xyz  |xyyzzz
        Example 3|code |coodddeeee
        Example 4|hello|heelllllllooooo
        Example 5|a    |a
        END
}

################################################################################
