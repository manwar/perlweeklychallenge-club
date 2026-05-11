use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 372
=========================

TASK #2
-------
*Largest Substring*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the length of the largest substring between two equal
characters excluding the two characters. Return -1 if there is no such sub-
string.

Example 1

  Input: $str = "aaaaa"
  Output: 3

  For character "a", we have substring "aaa".

Example 2

  Input: $str = "abcdeba"
  Output: 5

  For character "a", we have substring "bcdeb".

Example 3

  Input: $str = "abbc"
  Output: 0

  For character "b", we have substring "".

Example 4

  Input: $str = "abcaacbc"
  Output: 4

  For character "a", we have substring "bca".
  For character "b", we have substring "caac".
  For character "c", we have substring "aacb".

Example 5

  Input: $str = "laptop"
  Output: 2

  For character "p", we have substring "to".

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
3. If the constant VERBOSE is set to True, the largest substring(s) are listed
   in the output, immediately following the maximum length.

=end comment
#===============================================================================

use Test;

subset Result of List where (Int, Array[Str]);

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 372, Task #2: Largest Substring (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my (Int $max-len, Array[Str] $substrs) = find-largest-substring( $str );

    "Output: %d%s\n".printf: $max-len,
        VERBOSE ?? ' (' ~ $substrs.map( { qq["$_"] } ).join( ', ' ) ~ ')' !! '';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-largest-substring( Str:D $str --> Result:D )
#-------------------------------------------------------------------------------
{
    my Str  @substrings;
    my UInt %dict{Str},

    ++%dict{$_} for $str.split: '', :skip-empty;

    for %dict.keys.sort.grep: { %dict{$_} > 1 } -> Str $char
    {
        $str ~~ / $char (.*) $char /;
        @substrings.push: ~$0;
    }

    my Int $max-length = -1;

    for @substrings -> Str $substring
    {
        my UInt $len = $substring.chars;
        $max-length  = $len if $len > $max-length;
    }

    @substrings .= grep: { .chars == $max-length };

    return $max-length, @substrings;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected, @exp-subs) = $line.split: / \| /;

        for     $test-name, $str, $expected, @exp-subs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my (Int $max-len, Array[Str] $substrs) = find-largest-substring( $str );

        is        $max-len, $expected.Int, "$test-name: count";
        is-deeply $substrs, @exp-subs,     "$test-name: substrings";
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|aaaaa   | 3|aaa
        Example 2|abcdeba | 5|bcdeb
        Example 3|abbc    | 0|
        Example 4|abcaacbc| 4|caac|aacb
        Example 5|laptop  | 2|to
        None     |abcdefgh|-1
        END
}

################################################################################
