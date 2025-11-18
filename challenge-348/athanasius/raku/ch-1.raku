use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 348
=========================

TASK #1
-------
*String Alike*

Submitted by: Mohammad Sajid Anwar

You are given a string of even length.

Write a script to find out whether the given string can be split into two halves
of equal lengths, each with the same non-zero number of vowels.

Example 1

  Input: $str = "textbook"
  Output: false

  1st half: "text" (1 vowel)
  2nd half: "book" (2 vowels)

Example 2

  Input: $str = "book"
  Output: true

  1st half: "bo" (1 vowel)
  2nd half: "ok" (1 vowel)

Example 3

  Input: $str = "AbCdEfGh"
  Output: true

  1st half: "AbCd" (1 vowel)
  2nd half: "EfGh" (1 vowel)

Example 4

  Input: $str = "rhythmmyth"
  Output: false

  1st half: "rhyth" (0 vowel)
  2nd half: "mmyth" (0 vowel)

Example 5

  Input: $str = "UmpireeAudio"
  Output: false

  1st half: "Umpire" (3 vowels)
  2nd half: "eAudio" (5 vowels)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string of even length is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 348, Task #1: String Alike (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where { .chars %% 2 }                  #= A string of even length
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Bool $alike = string-alike( $str );

    "Output: %s\n".printf: $alike ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub string-alike( Str:D $str where { .chars %% 2 } --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt $str-len   =  $str.chars;
    my UInt $half-len  = ($str-len / 2).Int;
    my Str  $lhs       =  $str.substr: 0, $half-len;
    my UInt $lhs-count =  $lhs.comb( / :i <[ AEIOU ]> / ).elems;
    my Str  $rhs       =  $str.substr: $half-len;
    my UInt $rhs-count =  $rhs.comb( / :i <[ AEIOU ]> / ).elems;

    return  $lhs-count > 0 && $lhs-count == $rhs-count;
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

        my Bool $alike     = string-alike( $str );
        my Str  $alike-str = $alike ?? 'true' !! 'false';

        is $alike-str, $expected, $test-name;
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
        Example 1|textbook    |false
        Example 2|book        |true
        Example 3|AbCdEfGh    |true
        Example 4|rhythmmyth  |false
        Example 5|UmpireeAudio|false
        END
}

################################################################################
