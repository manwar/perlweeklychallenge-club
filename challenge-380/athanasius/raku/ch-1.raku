use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 380
=========================

TASK #1
-------
*Sum of Frequencies*

Submitted by: Mohammad Sajid Anwar

You are given a string consisting of English letters.

Write a script to find the vowel and consonant with maximum frequency. Return
the sum of two frequencies.

Example 1

  Input: $str = "banana"
  Output: 5

  Vowel: "a" appears 3 times.
  Consonant: "n" appears 2 times, "b" appears 1 time.

  Max frequency of vowel: 3
  Max frequency of consonant: 2

Example 2

  Input: $str = "teestett"
  Output: 7

  Vowel: "e" appears 3 times.
  Consonant: "t" appears 4 times, "s" appears 1 time.

  Max frequency of vowel: 3
  Max frequency of consonant: 4

Example 3

  Input: $str = "aeiouuaa"
  Output: 3

  Vowel: "a" appears 3 times, "u" 2 times, "e", "i", "o" 1 time each.
  Consonant: None.

  Max frequency of vowel: 3
  Max frequency of consonant: 0

Example 4

  Input: $str = "rhythm"
  Output: 2

  Vowel: None
  Consonant: "h" appears 2 times, "r", "y", "t", "m" 1 time each.

  Max frequency of vowel: 0
  Max frequency of consonant: 2

Example 5

  Input: $str = "x"
  Output: 1

  Vowel: None
  Consonant: "x" appears 1 time.

  Max frequency of vowel: 0
  Max frequency of consonant: 1

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
2. A string consisting of English letters only is entered on the command-line.

Assumptions
-----------
1. Letter comparisons are case-insensitive.
2. "English letters" do not include diacritics. So, for example, the spelling of
   "naïve" must be changed to "naive" for it to be a valid input string.

=end comment
#===============================================================================

use Test;

my regex LETTERS { :i ^ <[ A .. Z ]>* $ };

my Set constant VOWELS = set < A a E e I i O o U u >;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 380, Task #1: Sum of Frequencies (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where &LETTERS          #= A string of English letters
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $sum = sum-max-freqs( $str );

    "Output: $sum".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub sum-max-freqs( Str:D $str where &LETTERS --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt (%vowels, %consts);

    for $str.split: '', :skip-empty -> Str $char
    {
        my UInt %target := ($char ∈ VOWELS) ?? %vowels !! %consts;

        ++%target{ $char.lc };
    }

    my UInt $max-vowel = %vowels<>:k ?? (%vowels<>:v).max !! 0;
    my UInt $max-const = %consts<>:k ?? (%consts<>:v).max !! 0;

    return  $max-vowel + $max-const;
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

        my UInt $sum = sum-max-freqs( $str );

        is $sum, $expected.Int, $test-name;
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
        Example 1|banana  |5
        Example 2|teestett|7
        Example 3|aeiouuaa|3
        Example 4|rhythm  |2
        Example 5|x       |1
        Empty    |        |0
        END
}

################################################################################
