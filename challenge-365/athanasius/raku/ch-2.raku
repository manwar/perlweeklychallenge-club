use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 365
=========================

TASK #2
-------
*Valid Token Counter*

Submitted by: Mohammad Sajid Anwar

You are given a sentence.

Write a script to split the given sentence into space-separated tokens and count
how many are valid words. A token is valid if it contains no digits, has at most
one hyphen surrounded by lowercase letters, and at most one punctuation mark (!,
., ,) appearing only at the end.

Example 1

  Input: $str = "cat and dog"
  Output: 3

  Tokens: "cat", "and", "dog"

Example 2

  Input: $str = "a-b c! d,e"
  Output: 2

  Tokens: "a-b", "c!", "d,e"
  "a-b" -> valid (one hyphen between letters)
  "c!"  -> valid (punctuation at end)
  "d,e" -> invalid (punctuation not at end)

Example 3

  Input: $str = "hello-world! this is fun"
  Output: 4

  Tokens: "hello-world!", "this", "is", "fun"
  All satisfy the rules.

Example 4

  Input: $str = "ab- cd-ef gh- ij!"
  Output: 2

  Tokens: "ab-", "cd-ef", "gh-", "ij!"
  "ab-"   -> invalid (hyphen not surrounded by letters)
  "cd-ef" -> valid
  "gh-"   -> invalid
  "ij!"   -> valid

Example 5

  Input: $str = "wow! a-b-c nice."
  Output: 2

  Tokens: "wow!", "a-b-c", "nice."
  "wow!"  -> valid
  "a-b-c" -> invalid (more than one hyphen)
  "nice." -> valid

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Valid tokens contain only letters and specified punctuation characters (viz.,
hyphen, exclamation mark, full stop, comma). Other characters (e.g., "@", "*")
render a token invalid.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A sentence is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 365, Task #2: Valid Token Counter (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                          #= A sentence
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $count = count-valid-tokens( $str );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-valid-tokens( Str:D $str --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    for $str.split( / \s+ /, :skip-empty ) -> Str $token
    {
        # A token is valid if [and only if] it:

        # (1) contains no digits [or other non-specified characters]

        next if $token !~~ / ^ <[ A..Z a..z \- ! . , ]>* $ /;

        # (2) has at most one hyphen surrounded by lowercase letters

        my UInt $hyphens = $token.comb( / \- / ).elems;

        next if $hyphens > 1;

        if $hyphens == 1
        {
            next unless $token ~~ / <:Ll> \- <:Ll> /;
        }

        # (3) has at most one punctuation mark appearing only at the end

        next if $token ~~ / <[ ! . , ]> . /;

        ++$count;       # If we get here, the token is valid
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
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $count = count-valid-tokens( $str );

        is $count, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    exit 0;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|cat and dog             |3
        Example 2|a-b c! d,e              |2
        Example 3|hello-world! this is fun|4
        Example 4|ab- cd-ef gh- ij!       |2
        Example 5|wow! a-b-c nice.        |2
        Digit    |c4t and dog             |2
        Ampersand|cat &nd dog             |2
        END
}

################################################################################
