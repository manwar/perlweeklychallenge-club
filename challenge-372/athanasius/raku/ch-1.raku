use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 372
=========================

TASK #1
-------
*Rearrange Spaces*

Submitted by: Mohammad Sajid Anwar

You are given a string text of words that are placed among number of spaces.

Write a script to rearrange the spaces so that there is an equal number of
spaces between every pair of adjacent words and that number is maximised. If you
can’t distribute, place the extra spaces at the end. Finally return the string.

Example 1

  Input: $str = "  challenge  "
  Output: "challenge    "

  We have 4 spaces and 1 word. So all spaces go to the end.

Example 2

  Input: $str = "coding  is  fun"
  Output: "coding  is  fun"

  We have 4 spaces and 3 words (2 gaps). So 2 spaces per gap.

Example 3

  Input: $str = "a b c  d"
  Output: "a b c d "

  We have 4 spaces and 4 words (3 gaps). So 1 space per gap and 1 remainder.

Example 4

  Input: $str = "  team      pwc  "
  Output: "team          pwc"

  We have 10 spaces and 2 words (1 gap). So 10 spaces per gap.

Example 5

  Input: $str = "   the  weekly  challenge  "
  Output: "the    weekly    challenge "

  We have 9 spaces and 3 words (2 gaps). So 4 spaces per gap and 1 remainder.

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

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 372, Task #1: Rearrange Spaces (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $rearranged = rearrange-spaces( $str );

    qq[Output:       "$rearranged"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub rearrange-spaces( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    my UInt $n-spaces   = $str.comb( ' ' ).elems;
    my Str  @words      = $str.split: / \s+ /, :skip-empty;
    my UInt $n-words    = @words.elems;
    my Str  $rearranged = $str;           # Correct if $n-words == 0

    if    $n-words == 1
    {
        $rearranged = @words[0] ~ ' ' x $n-spaces;
    }
    elsif $n-words  > 1
    {
        my UInt $gap-size = ($n-spaces / ($n-words - 1)).floor;
        my Str  $gap      = ' ' x $gap-size;
        my UInt $end-size = $n-spaces - ($gap-size * ($n-words - 1));

        $rearranged = @words.join( $gap ) ~ ' ' x $end-size;
    }

    return $rearranged;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        $test-name ~~ s/ \s+ $ //;

        my Str $rearranged = rearrange-spaces( $str );

        is $rearranged, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1  |  challenge  |challenge    |
        Example 2  |coding  is  fun|coding  is  fun|
        Example 3  |a b c  d|a b c d |
        Example 4  |  team      pwc  |team          pwc|
        Example 5  |   the  weekly  challenge  |the    weekly    challenge |
        Spaces only|     |     |
        END
}

################################################################################
