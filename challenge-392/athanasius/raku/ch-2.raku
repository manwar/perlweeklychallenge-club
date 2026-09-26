use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 392
=========================

TASK #2
-------
*Words Length Product*

Submitted by: Mohammad Sajid Anwar

You are given an array of strings.

Write a script to return the maximum value of len($words[i]) * len($words[j])
where the two words do not share common letters. If no such two words exist,
return 0.

Example 1

  Input: @words = ("a", "ab", "abc", "d", "de", "def")
  Output: 9

  Two words are "abc" and "def".

Example 2

  Input: @words = ("a", "aa", "aaa", "aaaa")
  Output: 0

  Since no two words can be chosen without sharing letters, the result is 0.

Example 3

  Input: @words = ("meet", "app", "code", "sky", "bold")
  Output: 16

  Two words are "meet" and "bold".

Example 4

  Input: @words = ("a", "ab", "abc", "abcd", "efghi")
  Output: 20

  Two words are "abcd" and "efghi".

Example 5

  Input: @words = ("xyz", "w", "abcdefg", "hij")
  Output: 21

  Two words are "abcdefg" and "hij".

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
2. A list of strings is entered on the command-line.
3. If either "-v" or "--verbose" is entered as a command-line flag, the required
   output (viz., the maximum word length product) is supplemented with details
   of the two words whose lengths form that product. (If two or more pairs of
   words have the same maximum word length product, only the first pair found is
   shown.)

=end comment
#===============================================================================

use Test;

subset Result of List where (UInt, Str, Str);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 392, Task #2: Words Length Product (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@words where { .elems > 0 },                 #= A non-empty list of strings

    Bool :v(:$verbose)  #= Display the words whose lengths form the max product?
)
#===============================================================================
{
    "Input:  \@words = (%s)\n".printf: @words.map( { qq["$_"] } ).join: ', ';

    my (UInt $product, Str $word1, Str $word2) = find-product( @words );

    "Output: $product".put;

    qq[\nThe two words are "$word1" and "$word2"].put
        if $verbose && $product > 0;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-product( List:D[Str:D] $words --> Result:D )
#-------------------------------------------------------------------------------
{
    my Str  @ordered = $words.sort: { $^b.chars cmp $^a.chars || $^a cmp $^b };
    my UInt $product = 0;
    my Str  @words;

    L-OUTER:
    for 0 .. @ordered.end - 1 -> UInt $i
    {
        my UInt     $len1 = @ordered[$i].chars;
        my Set[Str] $set1 = Set[Str].new: @ordered[$i].split: '', :skip-empty;

        for $i + 1 .. @ordered.end -> UInt $j
        {
            my UInt $len2 = @ordered[$j].chars;

            next L-OUTER if $product >= $len1 * $len2;

            my Set[Str] $set2 =
               Set[Str].new: @ordered[$j].split: '', :skip-empty;

            if ($set1 ∩ $set2).elems == 0          # No shared letters
            {
                $product = $len1 * $len2;
                @words   = @ordered[$i, $j].sort;
            }
        }
    }

    return $product, @words[0], @words[1];
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $expected, @words) = $line.split: '|';

        for     $test-name, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my (UInt $product, Str $word1, Str $word2) = find-product( @words );

        is $product, $expected.Int, $test-name;
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
        Example 1| 9|a|ab|abc|d|de|def
        Example 2| 0|a|aa|aaa|aaaa
        Example 3|16|meet|app|code|sky|bold
        Example 4|20|a|ab|abc|abcd|efghi
        Example 5|21|xyz|w|abcdefg|hij
        Test     | 9|abcde|f|abf|egh|abde
        END
}

################################################################################
