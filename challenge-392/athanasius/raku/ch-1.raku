use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 392
=========================

TASK #1
-------
*Convert Palindrome*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to convert the given string to palindrome by adding characters in
front of it.

Example 1

  Input: $str = "pinnipeds"
  Output: "sdepinnipeds"

Example 2

  Input: $str = "abcd"
  Output: "dcbabcd"

Example 3

  Input: $str = "bananas"
  Output: "sananabananas"

Example 4

  Input: $str = "dissident"
  Output: "tnedissident"

Example 5

  Input: $str = "cailliachs"
  Output: "shcailliachs"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. If the input string is already a palindrome, no conversion is needed.
2. The empty string is a palindrome.
3. A string of one character is a palindrome.
4. If the input string is not a palindrome, it is to be converted into a palin-
   drome by prepending the *minimum* number of additional characters.
5. Comparison of characters is case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. Otherwise, a single string is entered on the command-line.
3. If the constant DEBUG is set to True, the conversion result is double-checked
   to ensure that it is a palindrome.

=end comment
#===============================================================================

use Test;

our Bool constant DEBUG = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 392, Task #1: Convert Palindrome (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Str $palindrome = convert-palindrome( $str );

    qq[Output: "$palindrome"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub convert-palindrome( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $palindrome;

    if    is-palindrome( $str )
    {
        $palindrome = $str;
    }
    elsif $str ~~ / ^ (.+) {} .? $( ~$0.flip ) (.*) $ /
    {
        $palindrome = ~$1.flip ~ $str;
    }
    else
    {
        $str ~~ / ^ . (.+) $ /;

        $palindrome = ~$0.flip ~ $str;
    }

    is-palindrome( $palindrome ) or die qq["$palindrome" is not a palindrome]
        if DEBUG;

    return $palindrome;
}

#-------------------------------------------------------------------------------
sub is-palindrome( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt $len = $str.chars;

    if $len > 1
    {
        for 0 .. ($len / 2 - 1).floor -> UInt $i
        {
            my UInt $j = $len - $i - 1;

            return False unless $str.substr( $i, 1 ) eq
                                $str.substr( $j, 1 );
        }
    }

    return True;
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

        my Str $palindrome = convert-palindrome( $str );

        is $palindrome, $expected, $test-name;
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
        Example 1   |pinnipeds                |sdepinnipeds
        Example 2   |abcd                     |dcbabcd
        Example 3   |bananas                  |sananabananas
        Example 4   |dissident                |tnedissident
        Example 5   |cailliachs               |shcailliachs
        Empty string|                         |
        Single char |X                        |X
        Palindrome  |able was I ere I saw elba|able was I ere I saw elba
        END
}

################################################################################
