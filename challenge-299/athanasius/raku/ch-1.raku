use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 299
=========================

TASK #1
-------
*Replace Words*

Submitted by: Mohammad Sajid Anwar

You are given an array of words and a sentence.

Write a script to replace all words in the given sentence that start with any of
the words in the given array.

Example 1

  Input: @words = ("cat", "bat", "rat")
         $sentence = "the cattle was rattle by the battery"
  Output: "the cat was rat by the bat"

Example 2

  Input: @words = ("a", "b", "c")
         $sentence = "aab aac and cac bab"
  Output: "a a a c b"

Example 3

  Input: @words = ("man", "bike")
         $sentence = "the manager was hit by a biker"
  Output: "the man was hit by a bike"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A sentence is entered on the command-line, followed by a list of words.

Assumptions
-----------
1. Matching is case-sensitive.
2. When words are replaced, punctuation should be retained.
3. If some of the given words are substrings of others, the shortest should be
   used as the replacement. For example, if the sentence is "I'm not ready for
   parenthood.", and the given words include both "parent" and "par", then re-
   placement should produce "I'm not ready for par."

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 299, Task #1: Replace Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $sentence,                     #= A sentence
          *@words                        #= A list of words
)
#===============================================================================
{
    qq[Input: \@words    = (%s)\n].printf: @words.map( { qq["$_"] } )\
                                                 .join: ', ';
    qq[       \$sentence =  "$sentence"].put;

    my Str $new-sentence = replace-words( $sentence, @words );

    qq[Output:             "$new-sentence"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub replace-words( Str:D $sentence, List:D[Str:D] $words --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $new-sentence = $sentence;

    for @$words -> Str $word
    {
        $new-sentence ~~ s:g/ <?wb> $word <-[ . ? ! , ; : " \s ]>+ /$word/;
    }

    return $new-sentence;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $sentence, $expected) =
                $line.split: / \| /;

        for     $test-name, $words-str, $sentence, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @words        = $words-str.split: / \s+ /, :skip-empty;
        my Str $new-sentence = replace-words( $sentence, @words );

        is $new-sentence, $expected, $test-name;
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
    my Str $data = q:to/END/;
        Example 1|cat bat rat|the cattle was rattle by the battery             \
                             |the cat was rat by the bat
        Example 2|a b c      |aab aac and cac bab                              \
                             |a a a c b
        Example 3|man bike   |the manager was hit by a biker                   \
                             |the man was hit by a bike
        Subset   |parent par |I'm not ready for parenthood                     \
                             |I'm not ready for par
        END

    return S:g/ \s* \\ \n \s* // given $data;
}

################################################################################
