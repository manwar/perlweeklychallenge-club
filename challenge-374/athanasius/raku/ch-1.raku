use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 374
=========================

TASK #1
-------
*Count Vowel*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return all possible vowel substrings in the given string. A
vowel substring is a substring that only consists of vowels and has all five
vowels present in it.

Example 1

  Input: $str = "aeiou"
  Output: ("aeiou")

Example 2

  Input: $str = "aaeeeiioouu"
  Output: ("aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu")

  NOTE: Updated output [2025-05-18]

Example 3

  Input: $str = "aeiouuaxaeiou"
  Output: ("aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua")

  NOTE: Updated output [2025-05-18]

Example 4

  Input: $str = "uaeiou"
  Output: ("aeiou", "uaeio", "uaeiou")

Example 5

  Input: $str = "aeioaeioa"
  Output: ()

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

Assumptions
-----------
1. Vowels are NOT case-sensitive.
2. The vowel substrings returned constitute a multiset, in which the order of
   the substrings does not matter.

Note on Testing
---------------
The algorithm employed returns vowel substrings ordered (1) by their location
in the string (left-most first), and then (2) by length (shortest first). This
produces a different ordering from that given in the Examples.

To accommodate this - and given Assumption 2 - test comparisons are performed by
cmp-ok() with the set identity operator (≡) applied to the actual and expected
vowel substring lists treated as bags (i.e., multisets).

=end comment
#===============================================================================

use Test;

my constant @VOWELS = < a e i o u >;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 374, Task #1: Count Vowel (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Str @vowel-substrings = find-vowel-substrings( $str );

    "Output: (%s)\n".printf: @vowel-substrings.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-vowel-substrings( Str:D $str --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str @chrs = $str.split: '', :skip-empty;
    my Str @vowel-substrs;

    for 0 .. @chrs.elems - @VOWELS.elems -> UInt $start
    {
        my Str  $start-chr  = @chrs[$start];
        my Bool $all-vowels = False;

        if $start-chr eq @VOWELS.any
        {
            my Str $substr = $start-chr;

            for $start + 1 .. @chrs.end -> UInt $current
            {
                my Str $chr = @chrs[$current];

                last unless $chr eq @VOWELS.any;

                $substr ~= $chr;

                if $all-vowels || has-all-the-vowels( $substr )
                {
                    @vowel-substrs.push: $substr;
                    $all-vowels = True;
                }
            }
        }
    }

    return @vowel-substrs;
}

#-------------------------------------------------------------------------------
sub has-all-the-vowels( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    for @VOWELS -> Str $vowel
    {
        return False unless $str ~~ m:i/ $vowel /;
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
        my Str ($test-name, $str,  @expected) = $line.split: '|', :skip-empty;

        for     $test-name, $str, |@expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @vowel-substrings = find-vowel-substrings( $str );

        cmp-ok @vowel-substrings.Bag, '≡', @expected.Bag, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|aeiou        |aeiou
        Example 2|aaeeeiioouu  |aaeeeiioou|aaeeeiioouu|aeeeiioou|aeeeiioouu
        Example 3|aeiouuaxaeiou|aeiou|aeiou|eiouua|aeiouu|aeiouua
        Example 4|uaeiou       |aeiou|uaeio|uaeiou
        Example 5|aeioaeioa    |
        END
}

################################################################################
