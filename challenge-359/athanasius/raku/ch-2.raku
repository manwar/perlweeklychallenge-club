use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 359
=========================

TASK #2
-------
*String Reduction*

Submitted by: Mohammad Sajid Anwar

You are given a word containing only alphabets,

Write a function that repeatedly removes adjacent duplicate characters from a
string until no adjacent duplicates remain and return the final word.

Example 1

  Input: $word = "aabbccdd"
  Output: ""

  Iteration 1: remove "aa", "bb", "cc", "dd" => ""

Example 2

  Input: $word = "abccba"
  Output: ""

  Iteration 1: remove "cc" => "abba"
  Iteration 2: remove "bb" => "aa"
  Iteration 3: remove "aa" => ""

Example 3

  Input: $word = "abcdef"
  Output: "abcdef"

  No duplicate found.

Example 4

  Input: $word = "aabbaeaccdd"
  Output: "aea"

  Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"

Example 5

  Input: $word = "mississippi"
  Output: "m"

  Iteration 1: Remove "ss", "ss", "pp" => "miiii"
  Iteration 2: Remove "ii", "ii" => "m"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Characters are "duplicates" only if they have the same case; e.g., "aa" and "AA"
are adjacent duplicate characters, but "aA" and "Aa" are not.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string containing alphabetic characters only is entered on the command-
   line.

=end comment
#===============================================================================

use Test;

my constant @ALPHABET = Array[Str].new: 'a' .. 'z';

subset Alpha of Str where * ~~ rx/ :i ^ <{ @ALPHABET.join: '||' }>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 359, Task #2: String Reduction (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Alpha:D $word,              #= A word composed of alphabetic characters only
)
#===============================================================================
{
    qq[Input:  \$word = "$word"].put;

    my Str $reduced-str = reduce-string( $word );

    qq[Output: "$reduced-str"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub reduce-string( Alpha:D $word )
#-------------------------------------------------------------------------------
{
    my Str $reduced-str = $word;

    Nil while $reduced-str ~~ s:g/ (.) $0 //;

    return $reduced-str;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $word, $expected) = $line.split: / \| /;

        for     $test-name, $word, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $reduced-str = reduce-string( $word );

        is $reduced-str, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
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
        Example 1|aabbccdd   |
        Example 2|abccba     |
        Example 3|abcdef     |abcdef
        Example 4|aabbaeaccdd|aea
        Example 5|mississippi|m
        END
}

################################################################################
